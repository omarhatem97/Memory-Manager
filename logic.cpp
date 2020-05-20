#include "logic.h"
#include "QString"
#include "QDebug"
#include "QtAlgorithms"
#include "QList"
#include "QPair"


using namespace std;




 bool compare_holes(logic::Hole &h1 , logic::Hole &h2)
 {
     return h1.starting_address <= h2.starting_address;
 }

 bool compare_memlocations(QPair<logic::MemoryContents,int> m1 , QPair<logic::MemoryContents,int> m2)
 {

     return (m1.first.end_address - m1.first.start_address) < (m2.first.end_address - m2.first.start_address);
 }



logic::logic(QObject *parent) : QObject(parent)
{
    memorySize = 0;
    can_add =0 ;
}



void logic::set_memorySize(QString size)
{
    memorySize = size.toInt();
     qDebug() << "memory size succes" << memorySize ;

}



QString logic::get_memorySize()
{
    return QString::number(memorySize);
}

void logic::add_hole(QString startingAddress, QString holeSize)
{
    Hole hole;
    hole.starting_address = startingAddress.toInt();
    hole.size = holeSize.toInt();

    if(hole.starting_address + hole.size <= memorySize)
            holes.append(hole);
}

void logic::add_segment(QString name, QString size)
{
    Segment segment;
    segment.name = name;
    segment.size = size.toInt();
    segments.append(segment);
    qDebug() << "succes" << segments[0].name ;
}

void logic::add_process(QString name, QString num_segments)
{
    Process process;
    process.name = name;
    process.num_segments = num_segments.toInt();
    process.segments = segments;

    segments.clear(); //clear segments list as soon as you add process to give room to the next process segments

    processes.append(process);

}

QString logic::get_segmentName(int idx)
{
    return segments[idx].name;
}




QString logic::test()
{
    qDebug() << "test succes" << segments[0].name ;
    return "hey";
}


void logic::set_memoryContents_firstFit()
{
    //set memory contents after pressing first fit butt
    QList <MemoryContents> memory_contentsc = memory_contents; //copy of memory contents
    Process p  = processes[processes.size()-1];

    int found = 0;
    //loop segments of the last process added
    for (int i = 0; i < p.segments.size(); ++i)
    {
        Segment s = p.segments[i];

        //loop over memory contents to find the best place
        for (int j = 0; j < memory_contentsc.size(); ++j)
        {
            MemoryContents m = memory_contentsc[j];
            found = 0;
            if(m.name[0] == "H")
            {
                if(m.end_address - m.start_address >= s.size)
                {
                    found =1;
                    addSegment_toMemorycontents(s,memory_contentsc, j);
                    break;
                }

            }
        }

        if(!found)
        {
            can_add = 0;
            return;
        }

    }

    if(found){
        memory_contents = memory_contentsc;
        can_add = 1;
    }

}

void logic::set_memoryContents_bestFit()
{
    QList <MemoryContents> memory_contentsc = memory_contents; //copy of memory contents
    Process p  = processes[processes.size()-1];

    int found = 0;

    QList<QPair<MemoryContents,int>>holes_loc; //list of all appropriate holes with their indecies

    //loop segments of the last process added
    for (int i = 0; i < p.segments.size(); ++i)
    {
        Segment s = p.segments[i];
        found = 0;
        //loop over memory contents to find the best place
        for (int j = 0; j < memory_contentsc.size(); ++j)
        {
            MemoryContents m = memory_contentsc[j];

            if(m.name[0] == "H")
            {
                if(m.end_address - m.start_address >= s.size)
                {
                    found =1;

                    holes_loc.append({m, j});
                }

            }
        }

        if(!found)
        {
            can_add = 0;
            return;
        }
        else {
            //find the best hole to be inserted at
            stable_sort(holes_loc.begin(), holes_loc.end(), compare_memlocations);
            addSegment_toMemorycontents(s , memory_contentsc , holes_loc[0].second);
            holes_loc.clear();
        }

    }

    if(found){
        memory_contents = memory_contentsc;
        can_add = 1;
    }
}






void logic::set_memoryContents_start()
{
    if(holes.size() == 0){
        MemoryContents m;
        //insert the process
        m.start_address = 0;
        m.end_address = memorySize;
        m.name = "process1";
        memory_contents.append(m);
        return;
    }
   //qDebug() << "holes size" << QString::number( holes.size()) << "--- hole 0 is" << holes[0].starting_address;
    int process_conter = 1; // indicate process num p1 , p2 ,p3 ..
    int idx = 0; // start of the loop
   //step 1 : sort holes base address
   sort(holes.begin(), holes.end(), compare_holes );

   // second combine the holes that are next to each other
   combine_holes();




   //step 2 : handle first hole

   int flag = 0;
   if(holes[0].starting_address > 0)
   {
       //insert process starting form zero-> starting add hole
       flag = 1;
       MemoryContents m1;
       m1.start_address = 0;
       m1.end_address = holes[0].starting_address;
       m1.name = "process" + QString::number(process_conter);
       memory_contents.append(m1);
       process_conter++;
   }

   //insert hole
   Hole hole = holes[0];
   MemoryContents m;
   m.start_address = hole.starting_address;
   m.end_address = hole.starting_address + hole.size;
   m.name = "HOLE";
   memory_contents.append(m);

   //step 3 add processes and holes in their suitable places

   if(flag) idx = 1;
   else idx = 0;

   for (int i = 1; i < holes.size(); i++)
   {
      Hole hole = holes[i];
      MemoryContents m;


      if( i < holes.size() -1) //check if index isn't out of range
      {
         // check if holes are right next each other or there is a gap
         // if there is a gap insert a process between them
          if(hole.starting_address+hole.size <  holes[i+1].starting_address)
          {
              //insert the process
              m.start_address = memory_contents[memory_contents.size()-1].end_address;
              m.end_address = holes[i].starting_address;
              m.name = "process" + QString::number(process_conter);
              memory_contents.append(m);
              process_conter++;

              //insert hole
              m.start_address = hole.starting_address;
              m.end_address = hole.starting_address + hole.size;
              m.name = "HOLE";
              memory_contents.append(m);
          }


      }
      else //means i am at the last hole
      {
          //check end address and memory size (smile xdd)
          if(hole.starting_address+hole.size <= memorySize)
          {
              if(memory_contents[memory_contents.size()-1].end_address < hole.starting_address)
              {
                  //insert process
                  m.start_address = memory_contents[memory_contents.size()-1].end_address;
                  m.end_address = holes[i].starting_address;
                  m.name = "process" + QString::number(process_conter);
                  memory_contents.append(m);
                  process_conter++;


                  //insert hole
                  m.start_address = hole.starting_address;
                  m.end_address = hole.starting_address + hole.size;
                  m.name = "HOLE";
                  memory_contents.append(m);

                  if(memory_contents[memory_contents.size()-1].end_address < memorySize){
                      //insert the process
                      m.start_address = hole.starting_address + hole.size;
                      m.end_address = memorySize;
                      m.name = "process" + QString::number(process_conter);
                      memory_contents.append(m);
                      process_conter++;
                  }

              }
              else {
                  //insert hole
                  m.start_address = hole.starting_address;
                  m.end_address = hole.starting_address + hole.size;
                  m.name = "HOLE";
                  memory_contents.append(m);


                  if(memory_contents[memory_contents.size()-1].end_address < memorySize){
                      qDebug() << "last end address: " << QString::number(memory_contents[memory_contents.size()-1].end_address)<< " where memory size is :" << memorySize;
                      //insert the process
                      m.start_address =  memory_contents[memory_contents.size()-1].end_address;
                      m.end_address = memorySize;
                      m.name = "process" + QString::number(process_conter);
                      memory_contents.append(m);
                      process_conter++;
                  }
              }

          }
      }



   }

   if(holes.size() ==1){
       int last_address = holes[0].starting_address + holes[0].size;
       if(last_address < memorySize)
       {
           MemoryContents m;
           m.name = "Process" + QString::number(process_conter);
           m.start_address = last_address;
           m.end_address = memorySize;
           memory_contents.append(m);
       }

   }



}//end function





void logic::draw_memory()
{
    // return a list with all data required for each process
    // 0->100 p1:100

}

int logic::get_memorycontents_size()
{
    return memory_contents.size();
}

QString logic::get_memoryContents(int idx)
{
    MemoryContents m = memory_contents[idx];
    return  m.name + " " + QString::number(m.start_address) + "->" + QString::number(m.end_address);
}

void logic::reset()
{
    segments.clear();
    processes.clear();
    memory_contents.clear();
    holes.clear();
    memorySize =0;
    process_segments.clear();
}

bool logic::get_can_add()
{
    return can_add;
}

void logic::get_process_segments(QString name)
{

    for (int i = 0; i < memory_contents.size(); ++i)
    {
        MemoryContents m = memory_contents[i];
        //get the process name from the memory contents
        QList<QString> curr_name = explode(m.name , ':');

        if(curr_name.size() == 1) continue;
        QString process_name = curr_name[1] ; QString segment_name = curr_name[0];

        if(process_name == name){
            process_segment s;
            s.name = segment_name;
            s.base = m.start_address;
            s.limit = m.end_address - m.start_address;
            process_segments.append(s);
        }

    }

}

QString logic::get_process_segment(int idx)
{
    process_segment p = process_segments[idx];
    return p.name + "  " + QString::number( p.base) + "  " +QString::number(p.limit);
}

int logic::get_table_size()
{
    return process_segments.size();
}

void logic::clear_process_segments()
{
    process_segments.clear();
}

void logic::deallocate_process(QString process_name)
{
    //it should dallocate the process with all it's segments from memory_contents
    for (int i = 0; i < memory_contents.size(); ++i)
    {
        MemoryContents &m = memory_contents[i];

        if(m.name.contains(process_name))
        {
            m.name = "HOLE";
        }
    }

    //try to combine the holes (saaaaaad)
     QList <MemoryContents> memory_contentsc;
     int flag = 1 ,from =0 , to =0 , appended = 0;

     if(memory_contents.size() == 1){
         return;
     }

    for (int i = 0; i < memory_contents.size(); ++i)
    {

        MemoryContents m = memory_contents[i];
        if(m.name.contains("HOLE"))
        {
            if(flag)
            {
                from = i;
                flag =0;
            }
            else {
                to = i;
            }

        }

        else {

            if(from != to)
            {
               MemoryContents temp;
               temp.name = "HOLE";
               temp.start_address = memory_contents[from].start_address;
               temp.end_address = memory_contents[i-1].end_address;
               memory_contentsc.append(temp);

               temp.name = memory_contents[i].name;
               temp.start_address = memory_contents[i].start_address;
               temp.end_address = memory_contents[i].end_address;
               memory_contentsc.append(temp);

               appended =1;


            }
            else {
                 memory_contentsc.append(m);
            }
            flag =1;
            from = to = i;
        }
    }

    if(!appended){
        MemoryContents temp;
        temp.name = "HOLE";
        temp.start_address = memory_contents[from].start_address;
        temp.end_address = memory_contents[memory_contents.size()-1].end_address;
        memory_contentsc.append(temp);
    }
    memory_contents = memory_contentsc;
}

void logic::combine_holes()
{
    int from =0 , to =0;
    QList<Hole> temp;


    int flag = 0;
    int appended = 0;

    for (int i =0; i<holes.size()-1; i++)
    {
        if (holes[i].starting_address+holes[i].size ==  holes[i+1].starting_address)
        {
            if(!flag) {
                from = i;
                flag =1;
            }
            to = i+1;

            if(i == holes.size()-2){
                Hole h;
                h.starting_address = holes[from].starting_address;
                h.size = (holes[to].starting_address + holes[to].size) - (holes[from].starting_address);
                temp.append(h);
                appended =1;
            }
        }
        else {
            flag =0;
            if(from != to)
            {
                Hole h;
                h.starting_address = holes[from].starting_address;
                h.size = holes[from].size + holes[to].size;
                temp.append(h);
                //appended = 1;
            }
            else {
               temp.append(holes[i]);
            }
            from = to = i;
        }
    }


    if(!appended){
        //if(from != to){
            Hole h;
            h.starting_address = holes[holes.size()-1].starting_address;
            h.size = holes[holes.size()-1].size;
            temp.append(h);
       // }
    }

    holes =temp;

    //debug oooooonly
    qDebug() << "hole size at end" << QString::number(holes.size());
    for (int i=0; i<holes.size(); i++) {
        qDebug() << "hole " << QString::number(holes[i].starting_address);
    }

}

void logic::addSegment_toMemorycontents(logic::Segment s,QList <MemoryContents> &memory_contentsc, int idx)
{

    //add segment to memory contents and hn8yar fel memroy_contents
    MemoryContents &m = memory_contentsc[idx];
    int remaining_size = (m.end_address - m.start_address) - s.size;

    if(remaining_size == 0)
    {
        m.name = s.name+ ":" + processes[processes.size()-1].name;;
    }
    else if(remaining_size > 0)
    {
       m.name = s.name + ":" + processes[processes.size()-1].name;
       int endaddress = m.end_address;
       m.end_address = m.start_address + s.size;

       //insert hole with the size of reaming size at the next idx
       MemoryContents new_content;
       new_content.name = "HOLE";
       new_content.start_address = m.end_address;
       new_content.end_address = endaddress;

       memory_contentsc.insert(idx+1 , new_content);

    }

}

QList<QString> logic::explode(QString &s , const QChar &c)
{
    QString buff{ "" };
       QList<QString>  v;

        for (auto n : s)
        {
            if (n != c) buff += n; else
                if (n == c && buff != "") { v.append(buff); buff = ""; }
        }
        if (buff != "") v.append(buff);

        return v;
}















