
<?php
date_default_timezone_set("Asia/Tehran");
$ip = "serverip";
$token = "servertoken";



//include "config.php";
$output = shell_exec('cat /etc/passwd | grep "/home/" | grep -v "/home/syslog"');
$userlist = preg_split("/\r\n|\n|\r/", $output);

$output1 = shell_exec('cat /etc/passwd | cut -d: -f1');
$userlist1 = preg_split("/\r\n|\n|\r/", $output1);

$pid = shell_exec("pgrep nethogs");
$pid = preg_replace("/\\s+/", "", $pid);

if (is_numeric($pid)) {
    $out = file_get_contents("/var/www/html/p/log/out.json");
    $trafficlog = preg_split("/\r\n|\n|\r/", $out);
    $trafficlog = array_filter($trafficlog);
    $lastdata = end($trafficlog);
    $json = json_decode($lastdata, true);
    $newarray = [];
    $online11 = [];
    foreach ($json as $value) {
        $TX =$value["TX"];
        $RX = $value["RX"];
        $name = preg_replace("/\\s+/", "", $value["name"]);
        if (strpos($name, "sshd") === false) {
            $name = "";
        }
        if (strpos($name, "root") !== false) {
            $name = "";
        }
        if (strpos($name, "[net]") !== false) {
            $name = "";
        }

        if (strpos($name, "[accepted]") !== false) {
            $name = "";
        }
        if (strpos($name, "[rexeced]") !== false) {
            $name = "";
        }
        if (strpos($name, "@notty") !== false) {
            $name = "";
        }
        if (strpos($name, "root:sshd") !== false) {
            $name = "";
        }
        if (strpos($name, "/sbin/sshd") !== false) {
            $name = "";
        }
        if (strpos($name, "[priv]") !== false) {
            $name = "";
        }
        if (strpos($name, "@pts/1") !== false) {
            $name = "";
        }
        if (strpos($name, "/usr/sbin/apache2") !== false) {
            $name = "";
        } 
        if (strpos($name, "/usr/sbin/nginx") !== false) {
            $name = "";
        }
        if (strpos($name, "/usr/sbin/dropbear") !== false) {
           $name = "";
        }
        if (strpos($name, "/usr/bin/stunnel5") !== false) {
            $name = "";
        }
        /*if ($value["RX"] < 1 && $value["TX"] < 1) {
            $name = "";
        }*/
        $name = str_replace("sshd:", "", $name);
        if (!empty($name)) {
            if (isset($newarray[$name])) {
                $newarray[$name]["TX"] + $TX;
                $newarray[$name]["RX"] + $RX;
                //$online11[$name]='0';
            } else {
                $newarray[$name] = ["RX" => $RX, "TX" => $TX, "Total" => $RX + $TX];
            }
        }
    }
   // var_dump($newarray);
    $oout= json_encode($newarray);
    $postParameter = array(
        'method' => 'multisrvsync',
        'datasyy'=> $oout
        
    );
    
    $curlHandle = curl_init('http://'.$ip.'/apiV2/api.php?token='.$token);
    curl_setopt($curlHandle, CURLOPT_POSTFIELDS, $postParameter);
    curl_setopt($curlHandle, CURLOPT_RETURNTRANSFER, true);
    $curlResponse = curl_exec($curlHandle);
    curl_close($curlHandle);
    $data = json_decode($curlResponse, true);
    //var_dump($data);
    //var_dump($data);
    //die;
    echo 'donme';
    $out = shell_exec("sudo killall -9 nethogs");
    shell_exec("sudo rm -rf /var/www/html/p/log/out.json");
    //sleep(2);
    $startnethogs = shell_exec("sudo nethogs -j  -v 3 > /var/www/html/p/log/out.json &");

} else {
    
    unlink("/var/www/html/p/log/out.json");
  
    $startnethogs = shell_exec("sudo nethogs -j  -v 3 > /var/www/html/p/log/out.json &");
    header("Refresh:1");
}
//die();
//aded online
$port="2096";
$list22 =  shell_exec("sudo lsof -i :8880 -n | grep -v root | grep ESTABLISHED");;
$duplicate = [];
$m = 1;

//var_dump($list22);
$onlineuserlist = preg_split("/\r\n|\n|\r/", $list22);
foreach($onlineuserlist as $user){
$user = preg_replace('/\s+/', ' ', $user);
$userarray = explode(" ",$user);
$onlinelist[] = $userarray[2];
}
$onlinecount = array_count_values($onlinelist);
//ended online
$newarray=
$postParameter = array(
    'method' => 'multiserver'
);
$curlHandle = curl_init('http://'.$ip.'/apiV2/api.php?token='.$token);
curl_setopt($curlHandle, CURLOPT_POSTFIELDS, $postParameter);
curl_setopt($curlHandle, CURLOPT_RETURNTRANSFER, true);
$curlResponse = curl_exec($curlHandle);
curl_close($curlHandle);
$data = json_decode($curlResponse, true);
$data = $data['data'];
$datuss=array();
$datsav=array();
$tee=0;
//var_dump($data);
//die();

// Convert JSON data from an array to a string

foreach ($data as $user){
   // $out = shell_exec('sh /var/www/html/adduser '.$user['username'].' '.$user['password']);
  //  echo $user['username'] ." added  <br>";

  $datuss[$tee]=$user['username'];
  $datsav[$tee][0]=$user['username'];
  $datsav[$tee][1]=$user['multiuser'];
    $tee++;
    if(!array_search($user['username'], $userlist1)){

        if (!empty($user['username'])) {
         $out = shell_exec('sh /var/www/html/adduser '.$user['username'].' '.$user['password']);
         echo $user['username'] ." added  <br>";
        }
        }
        //and chcked for multiuser
        $limitation = $user['multiuser'];
        $username = $user['username'];
        if (empty($limitation)){$limitation= "0";}
        //$userlist[$username] =  $limitation;
        
        if ($limitation !== "0" && $onlinecount[$username] > $limitation){
         
        }
        //end chhck
	
}
$path = '/var/www/html/ooo.json';
$jsonString = json_encode($datsav);
$fp = fopen($path, 'w');
fwrite($fp, $jsonString);
fclose($fp);
$out = shell_exec('sh /var/www/html/killusers.sh >/dev/null 2>&1' );
//var_dump($datsav);



foreach($userlist as $user){
    $userarray = explode(":",$user);
    if(!in_array($userarray[0], $datuss)){

if (!empty($userarray[0]) && $userarray[0] !='videocall') {
 $out = shell_exec('sh /var/www/html/delete '.$userarray[0]);
 echo $userarray[0] . " Removed  <br>";
}
}
}
$free = shell_exec("free");
$free = (string) trim($free);
$free_arr = explode("\n", $free);
$mem = explode(" ", $free_arr[1]);
$mem = array_filter($mem, function ($value) {
    return $value !== NULL && $value !== false && $value !== "";
});
$mem = array_merge($mem);
$memtotal = round($mem[1] / 1000000, 2);
$memused = round($mem[2] / 1000000, 2);
$memfree = round($mem[3] / 1000000, 2);
$memtotal = str_replace(" GB", "", $memtotal);
$memused = str_replace(" GB", "", $memused);
$memfree = str_replace(" GB", "", $memfree);
$memtotal = str_replace(" MB", "", $memtotal);
$memused = str_replace(" MB", "", $memused);
$memfree = str_replace(" MB", "", $memfree);
$usedperc = 100 / $memtotal * $memused;
$exec_loads = sys_getloadavg();
$exec_cores = trim(shell_exec("grep -P '^processor' /proc/cpuinfo|wc -l"));
$cpu = round($exec_loads[1] / ($exec_cores + 1) * 100, 0);
$diskfree = round(disk_free_space(".") / 1000000000);
$disktotal = round(disk_total_space(".") / 1000000000);
$diskused = round($disktotal - $diskfree);
$diskusage = round($diskused / $disktotal * 100);
$onlinecount["ram"]=$usedperc;
$onlinecount["cpu"]=$cpu;
$onlinecount["disk"]=$diskusage;
//var_dump();
$onnn=json_encode($onlinecount);
$postParameter = array(
    'method' => 'multisrvsynctrf',
    'online'=> $onnn
    
);

$curlHandle = curl_init('http://'.$ip.'/apiV2/api.php?token='.$token);
curl_setopt($curlHandle, CURLOPT_POSTFIELDS, $postParameter);
curl_setopt($curlHandle, CURLOPT_RETURNTRANSFER, true);
$curlResponse = curl_exec($curlHandle);
curl_close($curlHandle);
$data = json_decode($curlResponse, true);
//var_dump($data);



//header("Refresh:1");
?>
