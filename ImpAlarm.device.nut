led <- hardware.pin9;
BUTTON_FRIENDS <- hardware.pin2;
BUTTON_CAMPUS_POLICE <- hardware.pin5;
BUTTON_FOR_FUN <- hardware.pin7;

function LogDeviceOnline() {
    local reasonString = "Unknown";
    switch(hardware.wakereason()) {
        case WAKEREASON_PIN1:
            led.configure(DIGITAL_OUT_OD);
            led.write(0);
            break;
        default:
            GO_TO_SLEEP()
    }
} 

function GO_TO_SLEEP() {
    hardware.pin1.configure(DIGITAL_IN_WAKEUP)
    imp.onidle(function() {imp.deepsleepfor(2419198)})
}

function BUTTON_FRIENDS_CALLBACK() {
    if(BUTTON_FRIENDS.read() == 0) {
        imp.sleep(0.5);
        server.log("Send message to friends.")
        agent.send("BUTTON_FRIENDS", 0)
    }   
}
        
function BUTTON_CAMPUS_POLICE_CALLBACK() {
    if(BUTTON_CAMPUS_POLICE.read() == 0) {
        imp.sleep(0.5);
        server.log("Call campus police.")
        agent.send("BUTTON_CAMPUS_POLICE", 0)
    }
}

function BUTTON_FOR_FUN_CALLBACK() {
    if(BUTTON_FOR_FUN.read() == 0) {
        imp.sleep(0.5);
        server.log("For fun.")
        agent.send("BUTTON_FOR_FUN", 0)
    }
}

//RUNTIME STARTS
server.log("ready")
LogDeviceOnline();
imp.wakeup(3, GO_TO_SLEEP)
BUTTON_FRIENDS.configure(DIGITAL_IN_PULLUP, BUTTON_FRIENDS_CALLBACK)
BUTTON_CAMPUS_POLICE.configure(DIGITAL_IN_PULLUP, BUTTON_CAMPUS_POLICE_CALLBACK)
BUTTON_FOR_FUN.configure(DIGITAL_IN_PULLUP, BUTTON_FOR_FUN_CALLBACK)