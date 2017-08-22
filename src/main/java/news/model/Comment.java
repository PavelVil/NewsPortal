package news.model;

import javax.persistence.*;
import java.util.Date;


@Entity
@Table(name = "comments")
@NamedQueries({
        @NamedQuery(name = "Comment.getCommentsByPost",
                query = "select distinct c from Comment c left join fetch c.post p where c.post=:post ")
})
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "comment")
    private String comment;
    @Column(name = "createDate")
    private Date createDate =  new Date();
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "username_id")
    private User userName;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "post_id")
    private Post post;

    public Comment() {
    }

    public Comment(String comment, User user, Post post) {
        this.comment = comment;
        this.userName = user;
        this.post = post;
    }

    public Comment(User userName, Post post) {
        this.userName = userName;
        this.post = post;
    }

    public Comment(String comment) {
        this.comment = comment;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public User getUser() {
        return userName;
    }

    public void setUser(User user) {
        this.userName = user;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public User getUserName() {
        return userName;
    }

    public void setUserName(User userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", comment='" + comment + '\'' +
                ", userName=" + userName +
                ", post=" + post +
                '}';
    }
}
