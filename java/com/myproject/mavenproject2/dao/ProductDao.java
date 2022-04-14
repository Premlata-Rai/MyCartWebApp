package com.myproject.mavenproject2.dao;

import com.myproject.mavenproject2.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    //  
    public boolean saveProduct(Product prod ){
    boolean f = false;

        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            int catId = (int) session.save(prod);

            tx.commit();
            session.close();

            f = true;
        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }
        return f;
    }
    //get all products
    public List<Product> getAllProducts(){
        
        Session session = this.factory.openSession();
        Query qur= session.createQuery("from Product");
        List<Product> list = qur.list();
        
        return list;
    }

    //Get all products of given category
     public List<Product> getAllProductsByName(String ctitle){
        
        Session session = this.factory.openSession();
        Query query= session.createQuery("from Product as p where p.category.categoryTitle =: title");
        query.setParameter("title", ctitle);
        List<Product> list = query.list();
        
        return list;
    }
}
