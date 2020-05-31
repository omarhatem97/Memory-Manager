import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import com.company.logic 1.0
import QtQuick.Dialogs 1.1


Window {
    id: window
    visible: true
    width: 1280
    height: 720
    color: "#3a3e45"
    title: qsTr("Memory Manager")
    property var memorylist: []
    property var num_holes :0


    Mydata{
        id:yarab
    }

    MessageDialog {
        id: messageDialog
        title: "Error"
        text: "THIS ACTION CAN'T BE DONE !"
        onAccepted: {
            console.log("And of course you could only agree.")
            //Qt.quit()
        }
        Component.onCompleted: visible = false
    }



    Label {
        id: label11
        width: 311
        height: 27
        color: "#ffffff"
        text: "(2) Add holes then press save :"
        anchors.top: first_row.bottom
        anchors.topMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 26
        font.bold: true
        font.pointSize: 18
        font.family: "Times New Roman"
    }

    Rectangle {
        id: rectangle1
        width: 454
        height: 147
        color: "#f3f5f3"
        anchors.top: label11.bottom
        anchors.topMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 57

        Button {
            id: addHole_butt
            x: 334
            width: 100
            text: qsTr("Add hole")
            font.weight: Font.Bold
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 71
            anchors.top: parent.top
            anchors.topMargin: 46
            anchors.right: parent.right
            anchors.rightMargin: 20

            onClicked: {
                num_holes+=1
                logic.add_hole(starting_address.text, hole_size.text)
            }
        }

        RowLayout {
            x: 9
            y: 12

            Label {
                id: label3
                color: "#f16740"
                text: "Starting address:"
                Layout.preferredHeight: 31
                Layout.preferredWidth: 157
                font.pointSize: 16
                font.family: "Times New Roman"
                font.bold: true
            }

            TextField {
                id: starting_address
                font.pointSize: 10
                Layout.preferredHeight: 27
                Layout.preferredWidth: 96
                selectByMouse: true
            }
        }

        RowLayout {
            x: 11
            y: 62

            Label {
                id: label10
                color: "#f16740"
                text: "Hole size : "
                font.pointSize: 16
                font.family: "Times New Roman"
                font.bold: true
            }

            TextField {
                id: hole_size
                text: qsTr("")
                font.pointSize: 10
                Layout.preferredHeight: 27
                Layout.preferredWidth: 96
                selectByMouse: true
            }
        }

        Button {
            id: save_start_but
            y: 112
            height: 27
            text: qsTr("Save")
            font.weight: Font.Bold
            anchors.left: parent.left
            anchors.leftMargin: 177
            anchors.right: parent.right
            anchors.rightMargin: 177
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8


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
    }

    Label {
        id: label12
        x: 623
        y: 285
        width: 274
        height: 27
        color: "#ffffff"
        text: "Show segments of process :"
        font.family: "Times New Roman"
        font.pointSize: 18
        font.bold: true
    }

    Rectangle{
        id: rectangle2
        x: 623
        y: 449
        width: 214
        height: 251
        color: "#3a3e45"
        anchors.top: label14.bottom
        border.color: "white"
        border.width: 2

        ListView {
            id: segment_table
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            anchors.top: parent.top
            anchors.topMargin: 3
            delegate: Item {
              //  x: 5
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
    }



    Label {
        id: label13
        x: 623
        width: 293
        height: 37
        color: "#ffffff"
        text: "Enter process to deallocate :"
        anchors.top: parent.top
        anchors.topMargin: 138
        font.family: "Times New Roman"
        font.pointSize: 18
        font.bold: true
    }

    Label {
        id: label14
        x: 623
        y: 411
        width: 206
        height: 32
        color: "#f16740"
        text: " ID ->  BASE |  LIMIT"
        font.family: "Times New Roman"
        font.pointSize: 16
        font.bold: true
    }



    Label {
        id: label4
        color: "#ffffff"
        text: "(3) Enter process properties :"
        anchors.top: rectangle1.bottom
        anchors.topMargin: 11
        anchors.left: parent.left
        anchors.leftMargin: 26
        font.bold: true
        font.family: "Times New Roman"
        font.pointSize: 18
    }

    Label {
        id: label7
        color: "#ffffff"
        text: "(4) Select the method  :"
        anchors.top: rectangle.bottom
        anchors.topMargin: 17
        anchors.left: parent.left
        anchors.leftMargin: 35
        font.bold: true
        font.family: "Times New Roman"
        font.pointSize: 18
    }

    Rectangle {
        id: rectangle
        width: 332
        height: 280
        color: "#f3f5f3"
        anchors.top: label4.bottom
        anchors.topMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 57
        border.color: "black"

        RowLayout {
            width: 256
            height: 25
            anchors.top: parent.top
            anchors.topMargin: 16
            anchors.left: parent.left
            anchors.leftMargin: 16
            Label {
                id: label9
                color: "#f16740"
                text: qsTr("Process name :")
                font.bold: true
                fontSizeMode: Text.VerticalFit
                font.pointSize: 14
            }

            TextField {
                id: process_name
                text: qsTr("")
                font.pointSize: 10
                Layout.preferredHeight: 25
                Layout.preferredWidth: 107
                selectByMouse: true
            }
        }

        RowLayout {
            width: 250
            height: 25
            anchors.top: parent.top
            anchors.topMargin: 69
            anchors.left: parent.left
            anchors.leftMargin: 16
            Label {
                id: label
                color: "#f16740"
                text: qsTr("Number of segments :")
                font.bold: true
                fontSizeMode: Text.VerticalFit
                font.pointSize: 14
            }

            TextField {
                id: num_segments
                text: qsTr("")
                font.pointSize: 10
                Layout.preferredHeight: 25
                Layout.preferredWidth: 61
                selectByMouse: true
            }
        }

        RowLayout {
            width: 166
            height: 24
            spacing: 1
            anchors.top: parent.top
            anchors.topMargin: 123
            anchors.left: parent.left
            anchors.leftMargin: 16
            Label {
                id: label5
                color: "#f16740"
                text: qsTr("Name :")
                font.bold: true
                fontSizeMode: Text.Fit
                font.pointSize: 14
            }

            TextField {
                id: segment_name
                font.pointSize: 8
                font.capitalization: Font.MixedCase
                Layout.preferredHeight: 24
                Layout.preferredWidth: 85
                selectByMouse: true
            }
        }

        RowLayout {
            width: 142
            height: 27
            anchors.top: parent.top
            anchors.topMargin: 162
            anchors.left: parent.left
            anchors.leftMargin: 16
            Label {
                id: label6
                color: "#f16740"
                text: qsTr("Size :")
                font.bold: true
                styleColor: "#000000"
                fontSizeMode: Text.Fit
                font.pointSize: 14
            }

            TextField {
                id: segment_size
                height: 26
                font.pointSize: 8
                Layout.preferredHeight: 24
                Layout.preferredWidth: 85
                selectByMouse: true
            }
        }

        Button {
            id: addSegment_butt
            x: 116
            y: 142
            width: 100
            height: 33
            text: qsTr("Add Segment")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 105
            anchors.right: parent.right
            anchors.rightMargin: 24
            focusPolicy: Qt.ClickFocus
            font.weight: Font.Bold
            font.family: "Tahoma"
            display: AbstractButton.TextBesideIcon
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.capitalization: Font.MixedCase
            Layout.preferredHeight: 27
            Layout.preferredWidth: 100
            spacing: 0

            onClicked: {
                logic.add_segment(segment_name.text, segment_size.text);

            }
        }

        Button {
            id: add_process
            y: 225
            height: 27
            text: qsTr("Add process")
            font.weight: Font.Bold
            anchors.left: parent.left
            anchors.leftMargin: 116
            anchors.right: parent.right
            anchors.rightMargin: 116
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 28

            onClicked: {
                logic.add_process(process_name.text, num_segments.text)

            }
        }
    }


    Rectangle{
        id: rectangle4
       x: 991
       width: 268
       color: "#3a3e45"
       anchors.top: parent.top
       anchors.topMargin: 87
       anchors.bottom: parent.bottom
       anchors.bottomMargin: 95
       anchors.right: parent.right
       anchors.rightMargin: 21
       Label {
           id: memory_header
           x: -90
           width: 100
           height: 40
           color: "#f16740"
           text: "Memory"
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.top: parent.top
           anchors.topMargin: 0
           font.bold: true
           bottomPadding: 16
           Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
           font.pointSize: 38
           lineHeight: 0.7
           fontSizeMode: Text.VerticalFit
           horizontalAlignment: Text.AlignHCenter
       }

       ListView {
           id: listView
           anchors.top: parent.top
           anchors.topMargin: 54
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 0
           anchors.right: parent.right
           anchors.rightMargin: 0
           anchors.left: parent.left
           anchors.leftMargin: 0
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
                               id: memory_element
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
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }
               ListElement {
                   name: ""
               }

           }

           ScrollBar.vertical: ScrollBar {}

       }
   }




    RowLayout {
        id: first_row
        anchors.top: parent.top
        anchors.topMargin: 26
        anchors.left: parent.left
        anchors.leftMargin: 26

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
            text: qsTr("")
            font.pointSize: 10
            font.weight: Font.Normal
            font.wordSpacing: -0.1
            font.capitalization: Font.Capitalize
            Layout.preferredHeight: 27
            Layout.preferredWidth: 96

            selectByMouse: true
        }

        Button {
            id: confirm_memory
            text: qsTr("OK")
            font.weight: Font.Bold
            Layout.preferredHeight: 27
            Layout.preferredWidth: 71
            onClicked: {
                mylist.clear()
                memorylist.push(memory_size.text.toString())
                //logic.set_x(memory_size.text)
                logic.set_memorySize(memory_size.text);
                var memSize = logic.get_memorySize();
                for(var i =0 ; i< memSize; i++){
                    mylist.append({name : ""})
                }
            }
        }
    }

    RowLayout {
        y: 653
        width: 237
        height: 33
        anchors.topMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 73
        spacing: 20
        anchors.top: label7.bottom

        Button {
            id: firstfit_butt
            text: qsTr("First Fit")
            font.weight: Font.Bold
            Layout.preferredHeight: 33
            Layout.preferredWidth: 100


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
                else messageDialog.open();

            }
        }

        Button {
            id: best_fitbutt
            text: qsTr("Best Fit")
            font.weight: Font.Bold
            Layout.preferredHeight: 33
            Layout.preferredWidth: 100


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
                else {
                    console.log("your process can't be added yala")
                    messageDialog.open();
                }

            }
        }
    }

    RowLayout {
        x: 623
        anchors.top: label12.bottom
        anchors.topMargin: 17
        spacing: 20

        TextField {
            id: processName_tosegments
            font.pointSize: 10
            Layout.preferredHeight: 36
            Layout.preferredWidth: 113
            selectByMouse: true
        }

        Button {
            id: table_butt
            text: qsTr("ok")
            font.weight: Font.Bold
            Layout.preferredHeight: 33
            Layout.preferredWidth: 100

            onClicked: {
                rectangle2.border.color = "#3a3e45"
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
    }

    RowLayout {
        x: 628
        anchors.top: label13.bottom
        anchors.topMargin: 6
        spacing: 20

        TextField {
            id: deallocate_label
            font.pointSize: 10
            Layout.preferredHeight: 36
            Layout.preferredWidth: 108
            selectByMouse: true
        }

        Button {
            id: deallocate_but
            text: qsTr("ok")
            font.weight: Font.Bold
            Layout.preferredHeight: 33
            Layout.preferredWidth: 100

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

    RoundButton {
        id: myRoundButton
        x: 1204
        width: 45
        height: 45
        text: ""
        anchors.top: parent.top
        anchors.topMargin: 17
        anchors.right: parent.right
        anchors.rightMargin: 31

        background: Rectangle {
            id: rectangle3
            radius: myRoundButton.radius
            color: "#D61B40"

            Text {
                id: name
                text: qsTr("RESET")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                color: "white"
            }

        }


        onClicked: {
            memory_size.text = ""
            hole_size.text = ""
            starting_address.text = ""
            process_name.text = ""
            num_segments.text = ""
            segment_name.text = ""
            segment_size.text = ""
            processName_tosegments.text= ""
            deallocate_label.text = ""
            mylist.clear()
            table_list.clear()
            logic.reset()
            for(var i=0; i<10; i++){
                mylist.append({name : ""})
            }
        }

    }


}











































































/*##^## Designer {
    D{i:2;anchors_height:720;anchors_width:1280}D{i:3;anchors_x:28;anchors_y:69}D{i:5;anchors_height:30;anchors_y:40}
D{i:12;anchors_width:100;anchors_x:177}D{i:4;anchors_x:57;anchors_y:102}D{i:15;anchors_height:239;anchors_width:206;anchors_x:623;anchors_y:459}
D{i:21;anchors_y:138}D{i:22;anchors_x:0;anchors_y:260}D{i:23;anchors_x:0;anchors_y:260}
D{i:24;anchors_x:0;anchors_y:599}D{i:27;anchors_x:0;anchors_y:49}D{i:28;anchors_x:0;anchors_y:106}
D{i:26;anchors_x:0;anchors_y:49}D{i:30;anchors_x:0;anchors_y:49}D{i:31;anchors_x:0;anchors_y:163}
D{i:29;anchors_x:0;anchors_y:49}D{i:33;anchors_x:0;anchors_y:106}D{i:34;anchors_x:0;anchors_y:219}
D{i:32;anchors_x:0;anchors_y:106}D{i:36;anchors_width:100;anchors_x:0;anchors_y:163}
D{i:37;anchors_width:100;anchors_x:0;anchors_y:219}D{i:35;anchors_width:100;anchors_x:0;anchors_y:163}
D{i:38;anchors_width:100;anchors_x:0;anchors_y:219}D{i:39;anchors_height:538;anchors_width:100;anchors_x:0;anchors_y:219}
D{i:25;anchors_x:0;anchors_y:302}D{i:41;anchors_height:484;anchors_width:268;anchors_x:0;anchors_y:219}
D{i:50;anchors_x:26}D{i:51;anchors_y:26}D{i:54;anchors_x:73}D{i:55;anchors_x:26}D{i:58;anchors_x:73;anchors_y:329}
D{i:49;anchors_x:26}D{i:60;anchors_x:26;anchors_y:26}D{i:44;anchors_x:0;anchors_y:219}
D{i:43;anchors_x:0;anchors_y:219}D{i:42;anchors_height:484;anchors_width:268;anchors_x:0;anchors_y:36}
D{i:40;anchors_height:538;anchors_x:0;anchors_y:219}D{i:63;anchors_x:73;anchors_y:15}
D{i:64;anchors_x:26}D{i:61;anchors_y:181}D{i:67;anchors_x:73;anchors_y:329}D{i:65;anchors_x:26}
D{i:70;anchors_y:181}D{i:68;anchors_x:73;anchors_y:329}D{i:72;anchors_y:15}D{i:73;anchors_y:15}
D{i:71;anchors_y:181}
}
 ##^##*/
