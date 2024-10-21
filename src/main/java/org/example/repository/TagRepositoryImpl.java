package org.example.repository;

import jakarta.persistence.EntityManager;
import org.example.entity.Tag;
import org.example.repository.base.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TagRepositoryImpl extends Repository implements TagRepository,TagStatistic {

    @Override
    public void createTag(Tag tag) {
        executeInTransaction(em -> em.persist(tag));
    }

    @Override
    public Tag readTag(Long id) {
        EntityManager em = emf.createEntityManager();
        Tag tag = em.find(Tag.class, id);
        em.close();
        return tag;
    }

    @Override
    public void updateTag(Tag tag) {
        executeInTransaction(em -> em.merge(tag));
    }

    @Override
    public void deleteTag(Long id) {
        executeInTransaction(em ->
                {
                    Tag tag = em.find(Tag.class, id);
                    if (tag != null) {
                        em.remove(tag);
                    }
                }
        );
    }

    @Override
    public List<Tag> listTags() {
        EntityManager em = emf.createEntityManager();
        List<Tag> tags = em.createQuery("SELECT T FROM Tag T", Tag.class).getResultList();
        return tags;
    }

    @Override
    public Long getCount() {
        EntityManager em = emf.createEntityManager();
        return em.createQuery("SELECT COUNT(*) FROM Tag", Long.class).getSingleResult();
    }


    @Override
    public Map<Tag, Long> getCountTaskByTag() {
        EntityManager em = emf.createEntityManager();
        try {

            List<Object[]> results = em.createQuery(
                    "SELECT t, COUNT(tt) FROM Tag t JOIN t.tasks tt GROUP BY t", Object[].class
            ).getResultList();


            Map<Tag, Long> tagTaskCountMap = new HashMap<>();
            for (Object[] result : results) {
                Tag tag = (Tag) result[0];
                Long count = (Long) result[1];
                tagTaskCountMap.put(tag, count);
            }

            return tagTaskCountMap;
        } finally {
            em.close();
        }
    }


}
