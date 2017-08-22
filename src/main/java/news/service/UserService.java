package news.service;

import news.model.*;

import java.util.List;


public interface UserService {

    List<User> getAllUsers();

    User getUserByName(String name);

    void addUser(User user);

    void deleteUser(String name);

    List<Role> getAllRoles();

    void saveRole(User user, String role);

    void updateUser(User user);

    void addComment(Comment comment, User user, Post post);

    Comment getCommentById(Long id);

    void deleteComment(Long id);

    List<Comment> getCommentsByCategoryId(Post post);

}
