package news.service;

import news.dao.NewsDao;
import news.model.Category;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class CategoryServiceImpl implements NewsService<Category> {

    private NewsDao<Category> categoryDao;

    public void setCategoryDao(NewsDao<Category> categoryDao) {
        this.categoryDao = categoryDao;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> getAllWithDetail(Object param) {
        return null;
    }

    @Override
    public void add(Category element) {
        categoryDao.add(element);
    }

    @Override
    public void update(Category element) {
        categoryDao.update(element);
    }

    @Override
    @Transactional(readOnly = true)
    public Category getById(Long id) {
        return categoryDao.getById(id);
    }

    @Override
    public void delete(Long id) {
        categoryDao.delete(id);
    }

    @Override
    public Category getByName(String name) {
        return categoryDao.getByName(name);
    }
}
