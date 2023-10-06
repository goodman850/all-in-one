<?php
date_default_timezone_set("Asia/Tehran");
$ip = file_get_contents("/var/www/html/p/log/ip");
$token = file_get_contents("/var/www/html/p/log/token");


//include "config.php";
$output = shell_exec('cat /etc/passwd | grep "/home/" | grep -v "/home/syslog"');
$userlist = preg_split("/\r\n|\n|\r/", $output);

$output1 = shell_exec('cat /etc/passwd | cut -d: -f1');
$userlist1 = preg_split("/\r\n|\n|\r/", $output1);
$sysports = array();

$port_dropbear = shell_exec("$(ps aux | grep dropbear | awk NR==1 | awk '{print $17;}')");

$pids = shell_exec("$(ps ax | grep dropbear | grep " . $port_dropbear . " | awk -F\" \" '{print $1}')");

$sysports["vlesstls"] = NULL;
$sysports["vlessnone"] = NULL;
$sysports["trojan"] = NULL;
// Execute the shell command
$ws = shell_exec("cat ~/log-install.txt | grep -w 'OpenSSH' | cut -d: -f2 | sed 's/ //g'");

// Remove trailing newlines and spaces
$ws = trim($ws);
$sysports["ssh"] = $ws;
$ws = shell_exec("cat ~/log-install.txt | grep -w 'Dropbear' | cut -d: -f2 | sed 's/ //g'");

// Remove trailing newlines and spaces
$ws = trim($ws);
$sysports["sshtls"] = $ws;
$ws = shell_exec("cat ~/log-install.txt | grep -w 'Websocket None TLS' | cut -d: -f2 | sed 's/ //g'");

// Remove trailing newlines and spaces
$ws = trim($ws);
$sysports["sshws"] = $ws;
$ws = shell_exec("cat ~/log-install.txt | grep -w 'Websocket TLS' | cut -d: -f2 | sed 's/ //g'");

// Remove trailing newlines and spaces
$ws = trim($ws);
$sysports["sshwstls"] = $ws;

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
        $TX = $value["TX"];
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
    // $oout is ssh usage 
    //$ooutusage = json_encode($newarray,JSON_PRETTY_PRINT );
    $ooutusage = $newarray;
    //echo 'donme';
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
//go for dynamic 
$filename = '/var/www/html/p/log/dynamic';



// Check if the file exists
if (!file_exists($filename)) {
    // If it doesn't exist, create it
    


    $postParameter = array(
        'inialize' => 'inialize',
        'token' => $token


    );

    $curlHandle = curl_init('https://' . $ip . '/sd/apiV2/api.php' );
    curl_setopt($curlHandle, CURLOPT_POSTFIELDS, $postParameter);
    curl_setopt($curlHandle, CURLOPT_RETURNTRANSFER, true);
    $curlResponse = curl_exec($curlHandle);
    curl_close($curlHandle);
    $data = json_decode($curlResponse, true);
    $newString = $data["token"];
    $token111 = $data["token"];
    $file = fopen($filename, 'w');
    fwrite($file, $token111);
    
    fclose($file);
    $initial = 1;
} else {
    $fileContent = file_get_contents($filename);
    $token111 = $fileContent;
    if(empty($token111)){
        $postParameter = array(
            'inialize' => 'inialize',
            'token' => $token
    
    
        );
        $curlHandle = curl_init('https://' . $ip . '/sd/apiV2/api.php' );
        curl_setopt($curlHandle, CURLOPT_POSTFIELDS, $postParameter);
        curl_setopt($curlHandle, CURLOPT_RETURNTRANSFER, true);
        $curlResponse = curl_exec($curlHandle);
        
        curl_close($curlHandle);
        $data = json_decode($curlResponse, true);
        $newString = $data["token"];
        $token111 = $data["token"];
        $file = fopen($filename, 'w');
        fwrite($file, $token111);
        
        fclose($file);
        $initial = 1;
    }else{
        $initial = 0;
    }
    
}
$filename = '/var/www/html/p/log/dynamic';

    $fileContent = file_get_contents($filename);
   // $token111 = $fileContent;
//var_dump($fileContent);
//die();
//var_dump(file_put_contents($filename, $newString));
//end dynamic
$port = $sysports["ssh"];
$list22 = shell_exec("sudo lsof -i :" . $port . " -n | grep -v root | grep ESTABLISHED");
;

$m = 1;

//var_dump($list22);
$onlineuserlist = preg_split("/\r\n|\n|\r/", $list22);
foreach ($onlineuserlist as $user) {
    $user = preg_replace('/\s+/', ' ', $user);
    $userarray = explode(" ", $user);
    $onlinelist1[] = $userarray[2];
}
//$onlinecount = array_count_values($onlinelist);
//online for ssh :

//online for drop bear
$port = $port_dropbear;
$list22 = shell_exec("sudo lsof -i :" . $port . " -n | grep -v root | grep ESTABLISHED");


$m = 1;

//var_dump($list22);
$onlineuserlist = preg_split("/\r\n|\n|\r/", $list22);
if(!empty($onlineuserlist)){
foreach ($onlineuserlist as $user) {
    $user = preg_replace('/\s+/', ' ', $user);
    $userarray = explode(" ", $user);
    $onlinelist[] = $userarray[2];
}
}else{
    $onlinelist=[];
}
//$onlinecount = array_merge($onlinecount, $onlinecount1);
$onlinecount1 = array_count_values($onlinelist);

$onlinex = array("SSH" => [], "VLESS" => [], "TROJAN" => []);
$onlinex["SSH"] = $onlinecount1;

//ended online


//sort all usage
$traffix = array("SSH" => [], "VLESS" => [], "TROJAN" => []);
$traffix["SSH"] = $ooutusage;
//end usage
//get all server ram cpu
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
$systemusage = array();
$systemusage["ram"] = $usedperc;
$systemusage["cpu"] = $cpu;
$systemusage["disk"] = $diskusage;
//end ram cpu
$onlinex=json_encode($onlinex,JSON_PRETTY_PRINT );
$sysports=json_encode($sysports,JSON_PRETTY_PRINT );
$systemusage=json_encode($systemusage,JSON_PRETTY_PRINT );
$traffix=json_encode($traffix,JSON_PRETTY_PRINT );
$postParameter = array(
    'method' => 'syncdatausage',
    'dynamic' => $token111,
    'token' => $token,
    'onlines' => $onlinex,
    'ports' => $sysports,
    'systemUsages' => $systemusage,
    'trafficUsages' => $traffix
);
$curlHandle = curl_init('https://' . $ip . '/sd/apiV2/api.php');
curl_setopt($curlHandle, CURLOPT_POSTFIELDS, $postParameter);
curl_setopt($curlHandle, CURLOPT_RETURNTRANSFER, true);
$curlResponse = curl_exec($curlHandle);
curl_close($curlHandle);
$data = json_decode($curlResponse, true);
//liste user ha inja collect she array("SSH"=>[],"VLESS"=>[],"TROJAN"=>[])
$userdata = $data["usersdata"];
$sshdatasync = $userdata["SSH"];
$vlessdatasync = $userdata["VLESS"];
$trojandatasync = $userdata["TROJAN"];
$dynamicresp = !empty($data["token"])?$data["token"]:"";

//die();
//file_put_contents($filename, );
$filename = '/var/www/html/p/log/dynamic';

    $file = fopen($filename, 'w');
    fwrite($file, $dynamicresp);
    
    fclose($file);

$datuss = array();
$datsav = array();
$tee = 0;
//var_dump($data);
//die();

// sync ssh users from api server
if (!empty($sshdatasync)) {
    foreach ($sshdatasync as $user) {
        // $out = shell_exec('sh /var/www/html/adduser '.$user["username"].' '.$user["password"]);
        //  echo $user["username"] ." added  <br>";

        $datuss[$tee] = $user['username'];
        $datsav[$tee][0] = $user['username'];
        $datsav[$tee][1] = $user['multiuser'];
        //$datsav[$tee][2] = $user['change'];
        $tee++;
        if (!array_search($user['username'], $userlist1)) {

            if (!empty($user['username'])) {
                $out = shell_exec('sh /var/www/html/adduser ' . $user['username'] . ' ' . $user['password']);
                echo $user['username'] . " added  <br>";
            }
        }
        if($user['change']!= 0){
            $out = shell_exec('sh /var/www/html/delete ' . $user['username']);

            $out = shell_exec('sh /var/www/html/adduser ' . $user['username'] . ' ' . $user['password']);
              
        }
        //and chcked for multiuser
        $limitation = $user['multiuser'];
        $username = $user['username'];
        if (empty($limitation)) {
            $limitation = "0";
        }
        //$userlist[$username] =  $limitation;

        
        //end chhck

    }
    $path = '/var/www/html/ooo.json';
    $jsonString = json_encode($datsav,JSON_PRETTY_PRINT );
    $fp = fopen($path, 'w');
    fwrite($fp, $jsonString);
    fclose($fp);
   
    //var_dump($datsav);

}
// sync vless users from api server




foreach ($userlist as $user) {
    $userarray = explode(":", $user);
    if (!in_array($userarray[0], $datuss)) {

        if (!empty($userarray[0]) && $userarray[0] != 'videocall') {
            $out = shell_exec('sh /var/www/html/delete ' . $userarray[0]);
            echo $userarray[0] . " Removed  <br>";
        }
    }
}

//var_dump();
$out = shell_exec('sh /var/www/html/killusers.sh >/dev/null 2>&1');



//header("Refresh:1");
?>