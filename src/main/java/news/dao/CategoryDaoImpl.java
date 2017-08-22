package news.dao;

import news.model.Category;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryDaoImpl implements NewsDao<Category> {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Category> getAll() {
        return (List<Category>)sessionFactory.getCurrentSession().createQuery("from Category").list();
    }

    @Override
    public List<Category> getAllWithDetail(Object param) {
        return null;
    }


    @Override
    public void add(Category element) {
        sessionFactory.getCurrentSession().save(element);
    }

    @Override
    public void update(Category element) {
        sessionFactory.getCurrentSession().update(element);
    }

    @Override
    public Category getById(Long id) {
        return sessionFactory.getCurrentSession().get(Category.class,id);
    }

    @Override
    public void delete(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Category category = session.get(Category.class,id);
        if(category!=null){
            session.delete(category);
        }
    }

    @Override
    public Category getByName(String name) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Category where name=:name").setString("name",name);
        return (Category) query.uniqueResult();
    }



}
