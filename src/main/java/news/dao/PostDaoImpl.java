package news.dao;

import news.model.Post;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PostDaoImpl implements NewsDao<Post> {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Post> getAll() {
        return sessionFactory.getCurrentSession().getNamedQuery("Post.getAllDesc").list();
    }

    @Override
    public List<Post> getAllWithDetail(Object param) {
        return sessionFactory.getCurrentSession().getNamedQuery("Post.getAllWithDetail").setParameter("category",param).list();
    }

    @Override
    public void add(Post element) {
        sessionFactory.getCurrentSession().save(element);
    }

    @Override
    public void update(Post element) {
        sessionFactory.getCurrentSession().update(element);
    }

    @Override
    public Post getById(Long id) {
        return sessionFactory.getCurrentSession().get(Post.class,id);
    }

    @Override
    public void delete(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Post post = session.get(Post.class,id);
        if(post!=null){
            session.delete(post);
        }
    }

    @Override
    public Post getByName(String title) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Post where title=:title").setString("title",title);
        return (Post) query.uniqueResult();
    }
}
