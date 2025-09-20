import Quickshell
import QtQuick
import "modules/bar"
import Quickshell.Hyprland

ShellRoot {
    Bar {}
    FloatingWindow {
        id: test
        visible: false
        GlobalShortcut {
            name: "powerMenuOpen"
            description: "open Power menu"
            onPressed: {
                test.visible = !test.visible;
            }
        }
        Timer {
            id: timer
            property bool invert: false

            running: true
            repeat: true
            interval: 500
            onTriggered: timer.invert = !timer.invert
        }
        color: timer.invert ? "purple" : "green"
    }
}
