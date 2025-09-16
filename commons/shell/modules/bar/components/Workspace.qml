import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland
import QtQuick.Effects
import qs.services

// Hyprland workspace indicator
Rectangle {
    id: container
    color: Colors.surface
    radius: 12
    height: 25
    border.color: Colors.withOpacity(Colors.overlay, 0.3)
    border.width: 1

    Behavior on width {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutCubic
        }
    }

    Row {
        id: root
        anchors.centerIn: parent
        property var shell
        spacing: 5

        // Garder une référence au workspace actif précédent pour l'animation
        property var previousActiveWorkspace: null

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                id: workspace
                width: modelData.active ? 25 : 15
                height: 15
                radius: 50
                border.width: 0
                color: modelData.active ? Colors.text : Colors.muted
                opacity: modelData.active ? 1 : 0.6

                property bool wasActive: modelData.active

                states: [
                    State {
                        name: "becomingActive"
                        when: modelData.active && !wasActive
                        PropertyChanges {
                            target: workspace
                            scale: 1
                        }
                    },
                    State {
                        name: "becomingInactive"
                        when: !modelData.active && wasActive
                        PropertyChanges {
                            target: workspace
                            scale: 1
                        }
                    }
                ]

                transitions: [
                    Transition {
                        from: "*"
                        to: "becomingActive"
                        SequentialAnimation {
                            ParallelAnimation {
                                NumberAnimation {
                                    target: workspace
                                    property: "scale"
                                    to: 1
                                    duration: 200
                                }
                                NumberAnimation {
                                    target: workspace
                                    property: "opacity"
                                    to: 0.8
                                    duration: 200
                                }
                            }
                            ParallelAnimation {
                                NumberAnimation {
                                    target: workspace
                                    property: "scale"
                                    to: 1.0
                                    duration: 200
                                }
                                NumberAnimation {
                                    target: workspace
                                    property: "opacity"
                                    to: 1.0
                                    duration: 200
                                }
                            }
                        }
                    }
                ]

                Behavior on width {
                    NumberAnimation {
                        duration: 400
                        easing.type: Easing.InOutCubic
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        clickAnimation.start();
                        modelData.activate();
                    }
                }

                SequentialAnimation {
                    id: clickAnimation
                    NumberAnimation {
                        target: workspace
                        property: "scale"
                        to: 1.0
                        duration: 100
                    }
                    NumberAnimation {
                        target: workspace
                        property: "scale"
                        to: 1.0
                        duration: 200
                    }
                }

                // Mettre à jour wasActive quand l'état change
                onWasActiveChanged: {
                    wasActive = modelData.active;
                }

                Component.onCompleted: {
                    wasActive = modelData.active;
                }
            }
        }

        // Workspace synchronization
        Connections {
            target: Hyprland
            function onFocusedWorkspaceChanged() {
                Hyprland.refreshWorkspaces();
            }
        }
        onWidthChanged: {
            container.width = root.width + 25;
        }

        Component.onCompleted: {
            Hyprland.refreshWorkspaces();
            container.width = root.width + 25;
        }
    }
}
