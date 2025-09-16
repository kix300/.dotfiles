// Bar.qml
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.UPower
import qs.modules.bar.components
import qs.services

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            property real margin: 5
            screen: modelData
            // color: Colors.withOpacity(Colors.background, 0.8)
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            Rectangle {
                id: bar
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.withOpacity(Colors.surface, 0.9)
                radius: 8
                border.color: Colors.withOpacity(Colors.overlay, 0.3)
                border.width: 1
                Workspace {
                    id: workspace
                    anchors.left: bar.left
                    anchors.verticalCenter: bar.verticalCenter
                    anchors.leftMargin: 10
                }
                ClockWidget {
                    id: clockWidget
                    anchors.horizontalCenter: bar.horizontalCenter
                    anchors.verticalCenter: bar.verticalCenter
                }
                SystemWidget {
                    id: systemtray
                    anchors.right: bar.right
                    anchors.verticalCenter: bar.verticalCenter
                    anchors.rightMargin: 10
                }
            }
        }
    }
}
