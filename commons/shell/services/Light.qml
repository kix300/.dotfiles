pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int currentBrightness: 0
    property int maxBrightness: 255
    property int brightnessPercentage: 0
    property string deviceName: ""
    property string deviceClass: ""

    Timer {
        id: refreshTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            brightnessProcess.running = true;
        }
    }

    Process {
        id: brightnessProcess
        running: true
        command: ['brightnessctl']

        stdout: StdioCollector {
            onTextChanged: {
                parseBrightnessData(text.trim());
            }
        }
    }

    function parseBrightnessData(text) {
        var deviceMatch = text.match(/Device '([^']+)' of class '([^']+)':/);
        if (deviceMatch) {
            deviceName = deviceMatch[1];
            deviceClass = deviceMatch[2];
        }

        var currentMatch = text.match(/Current brightness:\s*(\d+)\s*\((\d+)%\)/);
        if (currentMatch) {
            currentBrightness = parseInt(currentMatch[1]);
            brightnessPercentage = parseInt(currentMatch[2]);
        }

        var maxMatch = text.match(/Max brightness:\s*(\d+)/);
        if (maxMatch) {
            maxBrightness = parseInt(maxMatch[1]);
        }
    }

    function getBrightnessIcon() {
        if (brightnessPercentage <= 10) {
            return "󰃞";
        } else if (brightnessPercentage <= 30) {
            return "󰃟";
        } else if (brightnessPercentage <= 60) {
            return "󰃠";
        } else {
            return "󰃡";
        }
    }
}
