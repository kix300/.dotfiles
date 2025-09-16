//widget and service :/
pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string status: "default"
    property int percentage: 0
    property bool charging: false
    property string color: "black"
    Timer {
        id: refreshTimer
        interval: 10000 // 10 sec
        running: true
        repeat: true
        onTriggered: {
            powerstatus.running = true;
        }
    }

    Process {
        id: powerstatus
        running: true
        command: ['bash', '-c', 'upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to full|percentage"']

        stdout: StdioCollector {
            onTextChanged: {
                root.status = setStatus(text.trim());
            }
        }
    }
    function setStatus(text: string): string {
        var percentageMatch = text.match(/percentage:\s*(\d+)%/);
        if (percentageMatch && percentageMatch[1]) {
            percentage = parseInt(percentageMatch[1]);
        }

        if (text.includes("discharging")) {
            charging = false;
        } else if (text.includes("charging")) {
            charging = true;
        }

        if (charging == true) {
            status = "󰂄";
        } else if (percentage <= 10) {
            status = "󰁺";
            color = "red";
        } else if (percentage <= 20) {
            status = "󰁻";
        } else if (percentage <= 30) {
            status = "󰁼";
        } else if (percentage <= 40) {
            status = "󰁽";
        } else if (percentage <= 50) {
            status = "󰁾";
        } else if (percentage <= 60) {
            status = "󰁿";
        } else if (percentage <= 70) {
            status = "󰂀";
        } else if (percentage <= 80) {
            status = "󰂁";
        } else if (percentage <= 90) {
            status = "󰂂";
        } else if (percentage <= 100) {
            status = "󰁹";
        }
        return status;
    }
}
