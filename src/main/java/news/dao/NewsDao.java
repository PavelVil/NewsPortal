package news.dao;

import java.util.List;


public interface NewsDao<T> {

    List<T> getAll();

    List<T> getAllWithDetail(Object param);

    void add(T element);

    void update(T element);

    T getById(Long id);

    void delete(Long id);

    T getByName(String name);


}
