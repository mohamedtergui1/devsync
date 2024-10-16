package org.example.service.tag;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.entity.Tag;


import java.util.List;

@Stateless
public class TagServiceImpl  implements TagService {

    // EJB will inject the EntityManager
    @PersistenceContext(unitName = "jpa")
    private EntityManager em;

    @Override
    public void createTag(Tag tag) {
        // No need to manually manage transactions; EJB will handle it
        em.persist(tag);
    }

    @Override
    public Tag readTag(Long id) {
        // Use the injected EntityManager to retrieve the entity
        return em.find(Tag.class, id);
    }

    @Override
    public void updateTag(Tag tag) {
        // EJB automatically manages the transaction for you
        em.merge(tag);
    }

    @Override
    public void deleteTag(Long id) {
        // Same as other methods, EJB will handle the transaction scope
        Tag tag = em.find(Tag.class, id);
        if (tag != null) {
            em.remove(tag);
        }
    }

    @Override
    public List<Tag> listTags() {
        // Query the database using the injected EntityManager
        return em.createQuery("SELECT t FROM Tag t", Tag.class).getResultList();
    }
}
