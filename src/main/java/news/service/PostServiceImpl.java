package news.service;

import news.dao.NewsDao;
import news.model.Post;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class PostServiceImpl implements NewsService<Post> {


    private NewsDao<Post> postDao;

    public void setPostDao(NewsDao<Post> postDao) {
        this.postDao = postDao;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Post> getAll() {
        return postDao.getAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Post> getAllWithDetail(Object param) {
        return postDao.getAllWithDetail(param);
    }

    @Override
    public void add(Post element) {
        postDao.add(element);
    }

    @Override
    public void update(Post element) {
        postDao.update(element);
    }

    @Override
    @Transactional(readOnly = true)
    public Post getById(Long id) {
        return postDao.getById(id);
    }

    @Override
    public void delete(Long id) {
        postDao.delete(id);
    }

    @Override
    public Post getByName(String title) {
        return postDao.getByName(title);
    }
}
