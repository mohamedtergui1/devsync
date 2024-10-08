package org.example.repository;

import jakarta.persistence.EntityManager;

import org.example.entity.Tag;

import java.util.List;

public class TagRepositoryImpl extends Repository  implements TagRepository {

    @Override
    public void createTag(Tag tag) {
       executeInTransaction(em -> em.persist(tag));
    }

    @Override
    public Tag readTag(Long id) {
        EntityManager em = emf.createEntityManager();
        Tag tag =em.find(Tag.class, id);
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
                   if(tag != null) {
                       em.remove(tag);
                   }
                }
        );
    }

    @Override
    public List<Tag> listTasks() {
        EntityManager em = emf.createEntityManager();
        List<Tag> tags = em.createQuery("SELECT T FROM Tag T", Tag.class).getResultList();
        return tags;
    }
}
