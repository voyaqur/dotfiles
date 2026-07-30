import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

// 1. The Status Bar
PanelWindow {
    anchors { top: true; left: true; right: true }
    implicitHeight: 30
    color: "#050505"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8

        // Workspace Indicator
        Text {
            visible: Hyprland.focusedWorkspace !== null
            text: "󰖯 " + (Hyprland.focusedWorkspace?.id ?? 0)
            color: "#0db9d7"
            font { pixelSize: 14; bold: true }
        }

        Item { Layout.fillWidth: true }

        // Clock
        Text {
            id: clockText
            font { pixelSize: 14; bold: true }
            color: "#ffffff"
            
            Timer {
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: clockText.text = Qt.formatDateTime(new Date(), "hh:mm  dd/MM/yyyy")
            }
        }
        
        Item { Layout.fillWidth: true }
    }
}

