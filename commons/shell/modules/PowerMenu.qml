import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.services

PanelWindow {
    id: test
    visible: false
    exclusiveZone: 0
    implicitWidth: 200
    color: "transparent"
    implicitHeight: 200
    WlrLayershell.namespace: "quickshell:powerMenuOpen"
    function hide() {
        test.visible = false;
    }
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    HyprlandFocusGrab { // Click outside to close
        id: grab
        windows: [test]
        active: test.visible
        onCleared: () => {
            if (!active){
                test.hide();
            }
        }
    }
    // gerer le escape
    // faire un rectangle creer le background
    // remplire du contenue que nous voulon
    Rectangle {
        id: powerMenu
        anchors.centerIn: parent
        color: Colors.surface
        implicitHeight: 200
        implicitWidth: 200
        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                test.hide();
            }
        }
    }
    GlobalShortcut {
        name: "powerMenuOpen"
        description: "open Power menu"
        onPressed: {
            test.visible = !test.visible;
        }
    }
}
