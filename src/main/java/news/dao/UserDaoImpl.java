package news.dao;

import news.model.*;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class UserDaoImpl implements UserDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<User> getAllUsers() {
        return (List<User>)sessionFactory.getCurrentSession().createQuery("from User").list();
    }

    @Override
    public User getUserByName(String name) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User where userName=:userName").setString("userName",name);
        return (User)query.uniqueResult();
    }

    @Override
    public void addUser(User user) {
        sessionFactory.getCurrentSession().save(user);
    }

    @Override
    public void deleteUser(String name) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User where userName=:userName").setString("userName",name);
        User user = (User) query.uniqueResult();
        if(user!=null){
            sessionFactory.getCurrentSession().delete(user);
        }
    }

    @Override
    public List<Role> getAllRoles() {
        return (List<Role>)sessionFactory.getCurrentSession().createQuery("from Role").list();
    }

    @Override
    public void saveRole(User user, String roleName) {
        if(user!=null && roleName!=null) {
            Role role = new Role(user);
            role.setAuthority(roleName);
            sessionFactory.getCurrentSession().save(role);
        }
    }

    @Override
    public void updateUser(User user) {
        sessionFactory.getCurrentSession().update(user);
    }

    @Override
    public void addComment(Comment comment, User user, Post post) {
        if (comment!=null){
            comment.setUser(user);
            comment.setPost(post);
            sessionFactory.getCurrentSession().save(comment);
        }
    }

    @Override
    public Comment getCommentById(Long id) {
        return sessionFactory.getCurrentSession().get(Comment.class, id);
    }

    @Override
    public void deleteComment(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Comment comment = session.get(Comment.class,id);
        if(comment!=null){
            session.delete(comment);
        }
    }

    @Override
    public List<Comment> getCommentsByCategoryId(Post post) {
        return sessionFactory.getCurrentSession().getNamedQuery("Comment.getCommentsByPost").setParameter("post",post).list();
    }
}
