package org.example.repository;

import org.example.entity.Tag;

import java.util.List;

public interface TagRepository {
    void createTag(Tag tag);
    Tag readTag(Long id);
    void updateTag(Tag tag);
    void deleteTag(Long id);
    List<Tag> listTasks();
}
