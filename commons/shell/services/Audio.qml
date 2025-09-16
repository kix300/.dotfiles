pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string state: "UNKNOWN"
    property int volumePercentage: 0
    property string sinkName: ""
    property string deviceBus: ""
    property string deviceNick: ""
    property string deviceAlias: ""
    property bool muted: false
    property string activePort: ""

    property int bluetoothBatteryPercentage: -1
    property bool bluetoothBatteryAvailable: false

    Timer {
        id: refreshTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            audioProcess.running = true;
            if (deviceBus === "bluetooth") {
                batteryProcess.running = true;
            }
        }
    }

    Process {
        id: batteryProcess
        command: ['sh', '-c', 'upower -i "$(upower -e | grep -E "headset")"']

        stdout: StdioCollector {
            onTextChanged: {
                if (text.trim()) {
                    parseBluetoothBattery(text.trim());
                }
            }
        }

        stderr: StdioCollector {
            onTextChanged: {
                if (text.trim()) {
                    bluetoothBatteryAvailable = false;
                    bluetoothBatteryPercentage = -1;
                }
            }
        }
    }

    Process {
        id: audioProcess
        running: true
        command: ['pactl', 'list', 'sinks']

        stdout: StdioCollector {
            onTextChanged: {
                parseAudioSinks(text.trim());
            }
        }
    }

    function parseAudioSinks(text) {
        var sinks = text.split(/Sink #\d+/);
        var activeSink = null;

        for (var i = 1; i < sinks.length; i++) {
            var sinkData = sinks[i];

            var stateMatch = sinkData.match(/State:\s*(\w+)/);
            if (stateMatch && stateMatch[1] === "RUNNING") {
                activeSink = sinkData;
                break;
            }
        }

        if (!activeSink && sinks.length > 1) {
            activeSink = sinks[1];
        }

        if (activeSink) {
            parseSinkData(activeSink);
        }
    }

    function parseSinkData(sinkData) {
        var stateMatch = sinkData.match(/State:\s*(\w+)/);
        if (stateMatch && stateMatch[1]) {
            state = stateMatch[1];
        }

        var volumeMatch = sinkData.match(/Volume:.*?(\d+)%/);
        if (volumeMatch && volumeMatch[1]) {
            volumePercentage = parseInt(volumeMatch[1]);
        }

        var muteMatch = sinkData.match(/Mute:\s*(yes|no)/);
        if (muteMatch && muteMatch[1]) {
            muted = (muteMatch[1] === "yes");
        }

        var nameMatch = sinkData.match(/Name:\s*(.+)/);
        if (nameMatch && nameMatch[1]) {
            sinkName = nameMatch[1].trim();
        }

        var busMatch = sinkData.match(/device\.bus\s*=\s*"([^"]+)"/);
        if (busMatch && busMatch[1]) {
            deviceBus = busMatch[1];
        }

        var nickMatch = sinkData.match(/device\.nick\s*=\s*"([^"]+)"/);
        if (nickMatch && nickMatch[1]) {
            deviceNick = nickMatch[1];
        }

        var aliasMatch = sinkData.match(/device\.alias\s*=\s*"([^"]+)"/);
        if (aliasMatch && aliasMatch[1]) {
            deviceAlias = aliasMatch[1];
        }

        var activePortMatch = sinkData.match(/Active Port:\s*(.+)/);
        if (activePortMatch && activePortMatch[1]) {
            activePort = activePortMatch[1].trim();
        }
    }

    function parseBluetoothBattery(text) {
        var percentageMatch = text.match(/percentage:\s*(\d+)%/);
        if (percentageMatch && percentageMatch[1]) {
            bluetoothBatteryPercentage = parseInt(percentageMatch[1]);
            bluetoothBatteryAvailable = true;
        } else {
            bluetoothBatteryAvailable = false;
            bluetoothBatteryPercentage = -1;
        }
    }

    function getVolumeIcon() {
        if (muted || volumePercentage === 0) {
            return "󰸈";
        } else if (volumePercentage <= 33) {
            return "󰕿";
        } else if (volumePercentage <= 66) {
            return "󰖀";
        } else {
            return "󰕾";
        }
    }

    function getDeviceIcon() {
        var baseIcon = "";
        var portLower = activePort.toLowerCase();
        var isHeadphones = portLower.includes("headphone") || portLower.includes("headset");
        var isSpeakers = portLower.includes("speaker") || portLower.includes("output-speaker");
        var isBluetooth = deviceBus === "bluetooth";

        if (isBluetooth && isHeadphones) {
            baseIcon = "󰂯";
        } else if (isBluetooth && !isHeadphones) {
            baseIcon = "󰋋";
        } else if (isHeadphones) {
            baseIcon = "󰋋";
        } else if (isSpeakers) {
            baseIcon = "󰓃";
        } else {
            baseIcon = "󰓃";
        }

        if (isBluetooth && bluetoothBatteryAvailable) {
            baseIcon += " " + getBluetoothBatteryIcon();
        }

        return baseIcon;
    }

    function getBluetoothBatteryIcon() {
        if (!bluetoothBatteryAvailable || bluetoothBatteryPercentage < 0) {
            return "";
        }

        if (bluetoothBatteryPercentage <= 10) {
            return "󰂎";
        } else if (bluetoothBatteryPercentage <= 25) {
            return "󰁺";
        } else if (bluetoothBatteryPercentage <= 50) {
            return "󰁼";
        } else if (bluetoothBatteryPercentage <= 75) {
            return "󰁽";
        } else {
            return "󰁹";
        }
    }

    function setVolume(percentage) {
        if (sinkName) {
            var setVolumeProcess = Quickshell.createProcess();
            setVolumeProcess.command = ['pactl', 'set-sink-volume', sinkName, percentage + '%'];
            setVolumeProcess.running = true;
        }
    }

    function toggleMute() {
        if (sinkName) {
            var toggleMuteProcess = Quickshell.createProcess();
            toggleMuteProcess.command = ['pactl', 'set-sink-mute', sinkName, 'toggle'];
            toggleMuteProcess.running = true;
        }
    }
}
