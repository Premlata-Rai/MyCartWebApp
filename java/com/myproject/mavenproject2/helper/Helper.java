 
package com.myproject.mavenproject2.helper;
 
import java.util.HashMap;
import java.util.Map;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class Helper {
    public static String get10Words(String desc)
    {
        String[] str = desc.split(" ");
        String res = "";
        if(str.length>10)
        {
           for(int i=0; i<10; i++){
               res = res+str[i]+" ";
           } 
           return (res+"..");
        }
        else{
            return (desc+"...");
        }
    }
    
    public static Map<String,Long> getCounts(SessionFactory factory){
        Session session = factory.openSession();
        String qur1 = "Select count(*) from UserEntity";
        String qur2 = "Select count(*) from Product";
        
        Query query1 = session.createQuery(qur1);
        Query query2 = session.createQuery(qur2);
        
        long userCount = (long)query1.list().get(0);
        long productCount = (long)query2.list().get(0);
        
        Map<String,Long> map = new HashMap();
        map.put("userCount",userCount);
        map.put("productCount",productCount);
        
        session.close();
        return map;
    }
    
}
