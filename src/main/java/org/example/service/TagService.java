package org.example.service;

import org.example.entity.Tag;

import java.util.List;

public interface TagService {
    void createTag(Tag tag);

    Tag readTag(long id);

    List<Tag> listTags();

    void updateTag(Tag tag);

    void deleteTag(Long id);

}
