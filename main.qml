import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import com.company.logic 1.0



Window {
    id: window
    visible: true
    width: 1280
    height: 720
    title: qsTr("Memory Manager")
    property var memorylist: []
    property var num_holes :0


    Mydata{
        id:yarab
    }

    Image {
        id: backgroundimage
        anchors.fill: parent
        source:  "qrc:/../../Pictures/allPics/backiee-99530.jpg"

        Label {
            id: label11
            x: 28
            y: 69
            width: 311
            height: 27
            color: "#ffffff"
            text: "(2) Add holes then press save :"
            font.bold: true
            font.pointSize: 18
            font.family: "Times New Roman"
        }

        Rectangle {
            id: rectangle1
            x: 57
            y: 102
            width: 454
            height: 147
            color: "#f3f5f3"

            Button {
                id: addHole_butt
                x: 333
                y: 40
                width: 100
                height: 30
                text: qsTr("Add hole")

                onClicked: {
                    num_holes+=1
                    logic.add_hole(starting_address.text, hole_size.text)
                }
            }

            TextField {
                id: hole_size
                x: 145
                y: 66
                width: 96
                height: 27
                text: qsTr("")
                Layout.preferredHeight: 27
                Layout.preferredWidth: 72
            }

            Label {
                id: label3
                x: 9
                y: 12
                width: 193
                height: 31
                color: "#ba55e1"
                text: "starting address"
                font.pointSize: 16
                font.family: "Times New Roman"
                font.bold: true
            }

            TextField {
                id: starting_address
                x: 219
                y: 12
                width: 96
                height: 27
                Layout.preferredHeight: 27
                Layout.preferredWidth: 72
            }

            Label {
                id: label10
                x: 11
                y: 62
                color: "#ba55e1"
                text: "Hole size : "
                font.pointSize: 16
                font.family: "Times New Roman"
                font.bold: true
            }
        }

        Label {
            id: label12
            x: 499
            y: 347
            width: 357
            height: 27
            color: "#ffffff"
            text: "Show segments of process :"
            font.family: "Times New Roman"
            font.pointSize: 18
            font.bold: true
        }

        TextField {
            id: processName_tosegments
            x: 499
            y: 398
            width: 113
            height: 36
        }

        ListView {
            id: segment_table
            x: 499
            y: 473
            width: 206
            height: 239
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row2
                    Rectangle {
                        width: 206
                        height: 30
                        border.color: "black"
                        color: "#eceeec"

                        Text {
                            text: name
                            padding: 16
                            font.pointSize: 14
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: true
                        }
                    }


                    spacing: 10
                }
            }
            model: ListModel {
                id:table_list

            }
        }

        Label {
            id: label13
            x: 557
            y: 115
            width: 345
            height: 37
            color: "#ffffff"
            text: "Enter process to deallocate"
            font.family: "Times New Roman"
            font.pointSize: 18
            font.bold: true
        }

        TextField {
            id: deallocate_label
            x: 576
            y: 158
            width: 108
            height: 40
        }

        Label {
            id: label14
            x: 499
            y: 440
            width: 206
            height: 27
            color: "#ffffff"
            text: " ID BASE LIMIT"
            font.family: "Times New Roman"
            font.pointSize: 16
            font.bold: true
        }

    }

    RowLayout {
        x: 26
        y: 26

        Label {
            id: label2
            color: "#ffffff"
            text: "(1) Enter the memory size : "
            font.bold: true
            font.family: "Times New Roman"
            font.pointSize: 18
        }

        TextField {
            id: memory_size
            width: 96
            text: qsTr("")
            font.weight: Font.Normal
            font.wordSpacing: -0.1
            font.capitalization: Font.Capitalize
            Layout.preferredHeight: 27
            Layout.preferredWidth: 72
            selectionColor: "#000000"
        }
    }

    Label {
        id: label4
        x: 26
        y: 260
        color: "#ffffff"
        text: "(3) Enter process properties :"
        font.bold: true
        font.family: "Times New Roman"
        font.pointSize: 18
    }

    Label {
        id: label7
        x: 35
        y: 599
        color: "#ffffff"
        text: "(4) Select the method  :"
        font.bold: true
        font.family: "Times New Roman"
        font.pointSize: 18
    }

    Button {
        id: best_fitbutt
        x: 164
        y: 653
        width: 100
        height: 33
        text: qsTr("Best Fit")

        onClicked: {

            logic.set_memoryContents_bestFit()
            var canBeAdded = logic.get_can_add()
            if(canBeAdded)
            {
                mylist.clear()

                var size = logic.get_memorycontents_size()
                //console.log("memory contents size : " , num_holes)
                for(var i =0 ; i<size; i++){
                    console.log(logic.get_memoryContents(i))
                    mylist.append({name : logic.get_memoryContents(i)})
                }
            }
            else console.log("your process can't be added yala")

        }
    }

    Button {
        id: firstfit_butt
        x: 35
        y: 653
        width: 100
        height: 33
        text: qsTr("First Fit")

        onClicked: {
            //dodo_shi
            logic.set_memoryContents_firstFit()
            var canBeAdded = logic.get_can_add()
            if(canBeAdded)
            {
                mylist.clear()

                var size = logic.get_memorycontents_size()
                //console.log("memory contents size : " , num_holes)
                for(var i =0 ; i<size; i++){
                    console.log(logic.get_memoryContents(i))
                    mylist.append({name : logic.get_memoryContents(i)})
                }
            }
            else console.log("your process can't be added yala")

        }
    }

    Rectangle {
        id: rectangle
        x: 57
        y: 301
        width: 332
        height: 280
        color: "#f3f5f3"
        border.color: "black"

        RowLayout {
            width: 230
            height: 25
            anchors.top: parent.top
            anchors.topMargin: 16
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                id: label9
                color: "#ba55e1"
                text: qsTr("Process name :")
                fontSizeMode: Text.VerticalFit
                font.pointSize: 14
            }

            TextField {
                id: process_name
                text: qsTr("")
                Layout.preferredHeight: 25
                Layout.preferredWidth: 107
            }
        }

        RowLayout {
            anchors.top: parent.top
            anchors.topMargin: 69
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                id: label
                color: "#ba55e1"
                text: qsTr("number of segments :")
                fontSizeMode: Text.VerticalFit
                font.pointSize: 14
            }

            TextField {
                id: num_segments
                text: qsTr("")
                Layout.preferredHeight: 25
                Layout.preferredWidth: 61
            }
        }

        RowLayout {
            width: 154
            height: 24
            spacing: 1
            anchors.top: parent.top
            anchors.topMargin: 123
            anchors.left: parent.left
            anchors.leftMargin: 16
            Label {
                id: label5
                color: "#ba55e1"
                text: qsTr("name :")
                fontSizeMode: Text.Fit
                font.pointSize: 14
            }

            TextField {
                id: segment_name
                Layout.preferredHeight: 24
                Layout.preferredWidth: 85
            }
        }

        RowLayout {
            anchors.top: parent.top
            anchors.topMargin: 165
            anchors.left: parent.left
            anchors.leftMargin: 16
            Label {
                id: label6
                color: "#ba55e1"
                text: qsTr("Size :")
                styleColor: "#000000"
                fontSizeMode: Text.Fit
                font.pointSize: 14
            }

            TextField {
                id: segment_size
                Layout.preferredHeight: 24
                Layout.preferredWidth: 85
            }
        }

        Button {
            id: addSegment_butt
            x: 201
            y: 142
            width: 107
            height: 33
            text: qsTr("ADD Segment")
            focusPolicy: Qt.ClickFocus
            font.weight: Font.Thin
            font.family: "Courier"
            display: AbstractButton.TextBesideIcon
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.capitalization: Font.AllUppercase
            Layout.preferredHeight: 27
            Layout.preferredWidth: 100
            spacing: 0

            onClicked: {
                logic.add_segment(segment_name.text, segment_size.text);

            }
        }

        Button {
            id: add_process
            x: 116
            y: 230
            width: 100
            height: 27
            text: qsTr("Add process")

            onClicked: {
                logic.add_process(process_name.text, num_segments.text)
            }
        }
    }

    Button {
        id: confirm_memory
        x: 480
        y: 30
        width: 71
        height: 27
        text: qsTr("OK")
        onClicked: {
            memorylist.push(memory_size.text.toString())
            //logic.set_x(memory_size.text)
            logic.set_memorySize(memory_size.text);
        }
    }

    Button {
        id: save_start_but
        x: 206
        y: 211
        width: 100
        height: 27
        text: qsTr("Save")


        onClicked: {

            console.log("you pressed save !")
            logic.set_memoryContents_start()
            var memory_size = logic.get_memorycontents_size()
            mylist.clear()
            console.log("memory contents size : " , logic.get_memorycontents_size())
            for(var i =0 ; i<memory_size; i++){
                console.log(logic.get_memoryContents(i))
                mylist.append({name : logic.get_memoryContents(i)})
            }
        }
    }

    Button {
        id: reset
        x: 1153
        y: 26
        width: 100
        height: 27
        text: qsTr("RESET")
        anchors.right: parent.right
        anchors.rightMargin: 27

        onClicked: {
            memory_size.text = ""
            hole_size.text = ""
            starting_address.text = ""
            process_name.text = ""
            num_segments.text = ""
            segment_name.text = ""
            segment_size.text = ""
            mylist.clear()
            table_list.clear()
            logic.reset()
        }
    }

    Label {
        id: label1
        x: 1016
        y: 65
        color: "#f16740"
        text: "Memory"
        font.bold: true
        bottomPadding: 16
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        font.pointSize: 28
        lineHeight: 0.7
        fontSizeMode: Text.VerticalFit
        horizontalAlignment: Text.AlignLeft
    }

    ListView {
        id: listView
        x: 960
        y: 130
        width: 268
        height: 484
        Layout.topMargin: 16
        Layout.preferredHeight: 533
        Layout.preferredWidth: 261


        delegate: Item {
            x: 5
            width: 80
            height: 45
            Layout.bottomMargin: 16
            property int indexOfThisDelegate: index

            Row {
                id: row1
                Layout.bottomMargin: 16
                property int indexOfThisDelegate: index
                Rectangle{
                    id:rect
                    color: "#eceeec"
                    border.color: "black"
                    anchors.verticalCenter: parent.verticalCenter
                    //                    anchors.horizontalCenter:parent.horizontalCenter
                    width: 261
                    height: 40
                    Row{
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            padding: 16

                            text: name
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: true
                            font.pointSize: 14

                        }



                    }
                    MouseArea {
                        width: 261
                        height: 40

                        onClicked: {
                            rect.color = "#FFFFFFFF"
                            listView.currentIndex = index
                            console.log("item clicked is : " +mylist.get(listView.currentIndex).name)
                        }
                    }
                }


                spacing: 150

            }
        }
        model: ListModel {
            id: mylist
            ListElement {
                limits: "0 -> 100"
                name : ""
                size : "100"

            }

        }

        ScrollBar.vertical: ScrollBar {}

    }

    Button {
        id: table_butt
        x: 628
        y: 400
        width: 100
        height: 33
        text: qsTr("ok")

        onClicked: {
            logic.clear_process_segments()
            logic.get_process_segments(processName_tosegments.text)
            table_list.clear()

            console.log("elmafrod cleared ... hwa lessa ?")
             var table_size = logic.get_table_size()
             console.log("table size :" + table_size)
             for(var i = 0; i<table_size; i++){
                 table_list.append({name : logic.get_process_segment(i)})
             }
        }
    }

    Button {
        id: deallocate_but
        x: 705
        y: 161
        width: 100
        height: 33
        text: qsTr("ok")

        onClicked: {
            logic.deallocate_process(deallocate_label.text)
            mylist.clear()

            var size = logic.get_memorycontents_size()
            //console.log("memory contents size : " , num_holes)
            for(var i =0 ; i<size; i++){
                console.log(logic.get_memoryContents(i))
                mylist.append({name : logic.get_memoryContents(i)})
            }
        }
    }


}





















/*##^## Designer {
    D{i:2;anchors_height:720;anchors_width:1280}D{i:30;anchors_x:0;anchors_y:49}D{i:29;anchors_x:0;anchors_y:49}
D{i:33;anchors_x:0;anchors_y:106}D{i:32;anchors_x:0;anchors_y:106}D{i:36;anchors_x:0;anchors_y:163}
D{i:35;anchors_x:0;anchors_y:163}D{i:39;anchors_x:0;anchors_y:219}D{i:38;anchors_x:0;anchors_y:219}
D{i:41;anchors_x:0;anchors_y:219}D{i:42;anchors_x:0;anchors_y:219}
}
 ##^##*/
