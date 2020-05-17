#ifndef LOGIC_H
#define LOGIC_H

#include <QObject>

class logic : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString segment_name READ get_segmentName)
//    Q_PROPERTY(QString toz READ test)


public:
    explicit logic(QObject *parent = nullptr);



    //data members
    int memorySize;
    int x;
    bool can_add;

    struct Hole{
        int starting_address , size;
    };



    struct Segment{
        QString name;
        int size;
    };

    struct process_segment{
        QString name;
        int base , limit;
    };

    struct Process{
        QString name;
        int num_segments;
        QList <Segment> segments;
    };

    struct MemoryContents{
        int start_address , end_address;
        QString name; // Code:100
    };

    QList <Hole> holes;   //contains all holes
    QList <Process> processes; // contains all processes
    QList <Segment> segments; // temp list that stores segments of a process
    QList <MemoryContents> memory_contents; // contains memory contents in order
    QList <process_segment> process_segments;

    //function members

    Q_INVOKABLE void set_memorySize(QString size);
    Q_INVOKABLE QString get_memorySize();
    Q_INVOKABLE void add_hole(QString startingAddress , QString holeSize); //add hole to holes list
    Q_INVOKABLE void add_segment(QString name , QString size);
    Q_INVOKABLE void add_process(QString name, QString num_segments);
    Q_INVOKABLE QString get_segmentName(int idx);
    Q_INVOKABLE QString test();
    Q_INVOKABLE void set_memoryContents_firstFit();
    Q_INVOKABLE void set_memoryContents_bestFit();
    Q_INVOKABLE void set_memoryContents_start();
    Q_INVOKABLE void draw_memory();
    Q_INVOKABLE int get_memorycontents_size();
    Q_INVOKABLE QString get_memoryContents(int idx);
    Q_INVOKABLE void reset();
    Q_INVOKABLE bool get_can_add();
    Q_INVOKABLE void get_process_segments(QString name);
    Q_INVOKABLE QString get_process_segment(int idx);
    Q_INVOKABLE int get_table_size();
    Q_INVOKABLE void clear_process_segments();
    Q_INVOKABLE void deallocate_process(QString process_name);

    //Helper functions

    void combine_holes();
    void addSegment_toMemorycontents(Segment s , QList <MemoryContents>&memory_contentsc,int idx);
    QList<QString> explode(QString &s, const QChar &c);

signals:

public slots:
};

#endif // LOGIC_H
