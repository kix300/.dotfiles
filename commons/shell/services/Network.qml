pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: networkService
    property string activeSsid: ""
    property bool connected: false
    property int signal: 0
    property string wifi: ""
    property string ethernet: ""
    property bool isEthernetConnected: false
    property string icon: "󰤭"

    ListModel {
        id: wifiModel
    }
    Timer {
        id: refreshTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            wifi: "";
            ethernet: "";
            ethernetCommandProc.running = true;
            wifiCommandProc.running = true;
        }
    }

    function parseEthernet(ethernet) {
        let isConnected = false;
        const lines = ethernet.split('\n');
        const header = lines[0];

        const deviceIndex = header.indexOf("DEVICE");
        const typeIndex = header.indexOf("TYPE");
        const stateIndex = header.indexOf("STATE");

        networkService.isEthernetConnected = false;
        for (let i = 0 + 1; i < lines.length; i++) {
            const line = lines[i];
            if (line.includes("ethernet") && line.includes("connected")) {
                networkService.isEthernetConnected = true;
            }
        }
        // Mettre à jour l'icône après avoir vérifié l'Ethernet
        networkService.icon = setNetworkIcon();
    }

    function parseWifi(wifi, ethernet) {
        wifiModel.clear();
        const lines = wifi.split('\n');

        const header = lines[0];
        const ssidIndex = header.indexOf("SSID");
        const modeIndex = header.indexOf("MODE");
        const signalIndex = header.indexOf("SIGNAL");
        const barsIndex = header.indexOf("BARS");
        const securityIndex = header.indexOf("SECURITY");

        let isConnected = false;
        networkService.activeSsid = "";
        networkService.connected = false;

        for (let i = 0 + 1; i < lines.length; i++) {
            const line = lines[i];
            if (line.trim().length === 0) {
                continue;
            }

            const isLineConnected = line.startsWith('*');
            const ssid = line.substring(ssidIndex + 16, modeIndex).trim();
            const signal = line.substring(signalIndex, barsIndex).trim();

            if (ssid === '--' || ssid === "") {
                continue;
            }

            wifiModel.append({
                name: ssid,
                signal: parseInt(signal) || 0,
                connected: isLineConnected
            });

            if (isLineConnected) {
                networkService.activeSsid = ssid;
                networkService.signal = parseInt(signal) || 0;
                isConnected = true;
            }
        }
        networkService.connected = isConnected;
        networkService.icon = setNetworkIcon();
    }

    function setNetworkIcon(): string {
        if (isEthernetConnected) {
            return "󰈀";
        }
        if (connected) {
            if (signal >= 75) {
                return "󰤨";
            } else if (signal >= 50) {
                return "󰤥";
            } else if (signal >= 25) {
                return "󰤢";
            } else if (signal > 0) {
                return "󰤟";
            } else {
                return "󰤯";
            }
        }
        return "󰤭";
    }

    Process {
        id: ethernetCommandProc
        command: ["nmcli", "device", "status"]
        stdout: StdioCollector {
            onStreamFinished: {
                ethernet = text.trim();
                parseEthernet(ethernet);
            }
        }
    }
    Process {
        id: wifiCommandProc
        command: ["nmcli", "dev", "wifi", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                wifi = text.trim();
                parseWifi(wifi, ethernet);
            }
        }
    }
}
