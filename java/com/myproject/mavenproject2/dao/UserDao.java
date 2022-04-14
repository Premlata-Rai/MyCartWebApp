 
package com.myproject.mavenproject2.dao;
 
import com.myproject.mavenproject2.entities.UserEntity;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class UserDao {
  private SessionFactory factory;
  
  public UserDao(SessionFactory factory){
      this.factory = factory;
  }
  
  //Get user by email and password
  public UserEntity  getUserByEmailAndPassword(String email, String password){
      UserEntity  user = null;
      
      try{
          String query = "from UserEntity  where userEmail =: e and userPassword=: p";
          Session session = this.factory.openSession();
          Query qur = session.createQuery(query);
          qur.setParameter("e", email);
          qur.setParameter("p", password);
          
          user = (UserEntity)qur.getSingleResult();
          session.close();
      }
      
      catch(Exception e){
          e.printStackTrace();
      }
      return user;
  }
  
}
