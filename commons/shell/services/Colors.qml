pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // Base16 color properties
    property string base00: "#272e33"  // Default background
    property string base01: "#2e383c"  // Lighter background
    property string base02: "#414b50"  // Selection background
    property string base03: "#859289"  // Comments, invisibles
    property string base04: "#9da9a0"  // Dark foreground
    property string base05: "#d3c6aa"  // Default foreground
    property string base06: "#edeada"  // Light foreground
    property string base07: "#fffbef"  // Light background
    property string base08: "#e67e80"  // Variables, XML Tags, Markup Link Text
    property string base09: "#e69875"  // Integers, Boolean, Constants
    property string base0A: "#dbbc7f"  // Classes, Markup Bold, Search Text Background
    property string base0B: "#a7c080"  // Strings, Inherited Class, Markup Code
    property string base0C: "#83c092"  // Support, Regular Expressions, Escape Characters
    property string base0D: "#7fbbb3"  // Functions, Methods, Attribute IDs, Headings
    property string base0E: "#d699b6"  // Keywords, Storage, Selector, Markup Italic
    property string base0F: "#9da9a0"  // Deprecated, Opening/Closing Embedded Language Tags

    // Additional semantic color properties for UI components
    property string background: base00
    property string surface: base01
    property string overlay: base02
    property string muted: base03
    property string subtle: base04
    property string text: base05
    property string love: base08
    property string gold: base0A
    property string rose: base09
    property string pine: base0B
    property string foam: base0C
    property string iris: base0D
    property string highlight: base0E

    // Palette metadata
    property string scheme: "Everforest Dark Hard"
    property string author: "Sainnhe Park"

    Component.onCompleted: {
        loadPalette();
    }

    Timer {
        id: refreshTimer
        interval: 5000  // Check for palette changes every 5 seconds
        running: true
        repeat: true
        onTriggered: {
            loadPalette();
        }
    }

    Process {
        id: paletteProcess
        command: ['cat', '/home/ozen/.config/stylix/palette.json']

        stdout: StdioCollector {
            onTextChanged: {
                if (text.trim()) {
                    parsePalette(text.trim());
                }
            }
        }
    }

    function loadPalette() {
        paletteProcess.running = true;
    }

    function parsePalette(jsonText) {
        try {
            var palette = JSON.parse(jsonText);

            // Update base16 colors (add # prefix if missing)
            if (palette.base00)
                base00 = "#" + palette.base00;
            if (palette.base01)
                base01 = "#" + palette.base01;
            if (palette.base02)
                base02 = "#" + palette.base02;
            if (palette.base03)
                base03 = "#" + palette.base03;
            if (palette.base04)
                base04 = "#" + palette.base04;
            if (palette.base05)
                base05 = "#" + palette.base05;
            if (palette.base06)
                base06 = "#" + palette.base06;
            if (palette.base07)
                base07 = "#" + palette.base07;
            if (palette.base08)
                base08 = "#" + palette.base08;
            if (palette.base09)
                base09 = "#" + palette.base09;
            if (palette.base0A)
                base0A = "#" + palette.base0A;
            if (palette.base0B)
                base0B = "#" + palette.base0B;
            if (palette.base0C)
                base0C = "#" + palette.base0C;
            if (palette.base0D)
                base0D = "#" + palette.base0D;
            if (palette.base0E)
                base0E = "#" + palette.base0E;
            if (palette.base0F)
                base0F = "#" + palette.base0F;

            // Update semantic colors
            background = base00;
            surface = base01;
            overlay = base02;
            muted = base03;
            subtle = base04;
            text = base05;
            love = base08;
            gold = base0A;
            rose = base09;
            pine = base0B;
            foam = base0C;
            iris = base0D;
            highlight = base0E;

            // Update metadata
            if (palette.scheme)
                scheme = palette.scheme;
            if (palette.author)
                author = palette.author;
        } catch (error) {
            console.log("Error parsing palette JSON:", error);
        }
    }

    // Utility functions for color manipulation
    function withOpacity(color, opacity) {
        // Convert hex color to rgba with specified opacity
        var hex = color.replace('#', '');
        var r = parseInt(hex.substr(0, 2), 16);
        var g = parseInt(hex.substr(2, 2), 16);
        var b = parseInt(hex.substr(4, 2), 16);
        return "rgba(" + r + ", " + g + ", " + b + ", " + opacity + ")";
    }

    function darken(color, amount) {
        // Simple darkening function (would need more complex implementation for production)
        return color; // Placeholder
    }

    function lighten(color, amount) {
        // Simple lightening function (would need more complex implementation for production)
        return color; // Placeholder
    }
}
