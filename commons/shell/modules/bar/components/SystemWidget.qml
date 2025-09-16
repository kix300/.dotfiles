// faire un widget global
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.services

Rectangle {
    id: container
    color: Colors.surface
    radius: 12
    height: 25

    width: Math.max(minimumWidth, systemtray.implicitWidth + leftPadding + rightPadding)

    property int minimumWidth: 60
    property int leftPadding: 10
    property int rightPadding: 10

    Behavior on width {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    RowLayout {
        id: systemtray
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: container.leftPadding
        anchors.rightMargin: container.rightPadding
        spacing: 12
        layoutDirection: Qt.LeftToRight

        Text {
            id: powerText
            Layout.alignment: Qt.AlignVCenter
            color: Colors.text
            text: Power.status
        }

        BrightnessWidget {
            id: brightness
            Layout.alignment: Qt.AlignVCenter
        }

        AudioWidget {
            id: audio
            Layout.alignment: Qt.AlignVCenter
        }

        NetworkWidget {
            id: network
            Layout.alignment: Qt.AlignVCenter
        }
    }

    border.color: Colors.withOpacity(Colors.overlay, 0.3)
    border.width: 1
}
