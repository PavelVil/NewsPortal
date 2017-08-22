package news.service;

import news.dao.UserDao;
import news.model.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class UserServiceImpl implements UserService {

    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }

    @Override
    @Transactional(readOnly = true)
    public User getUserByName(String name) {
        return userDao.getUserByName(name);
    }

    @Override
    public void addUser(User user) {
        userDao.addUser(user);
    }

    @Override
    public void deleteUser(String name) {
        userDao.deleteUser(name);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Role> getAllRoles() {
        return userDao.getAllRoles();
    }

    @Override
    public void saveRole(User user, String role) {
        userDao.saveRole(user, role);
    }

    @Override
    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    @Override
    public void addComment(Comment comment, User user, Post post) {
        userDao.addComment(comment,user,post);
    }

    @Override
    @Transactional(readOnly = true)
    public Comment getCommentById(Long id) {
        return userDao.getCommentById(id);
    }

    @Override
    public void deleteComment(Long id) {
        userDao.deleteComment(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Comment> getCommentsByCategoryId(Post post) {
        return userDao.getCommentsByCategoryId(post);
    }
}
