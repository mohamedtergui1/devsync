package org.example.service.tag;

import org.example.entity.Tag;

import java.util.List;

public interface TagService {
    void createTag(Tag tag);

    Tag readTag(Long id);

    void updateTag(Tag tag);

    void deleteTag(Long id);

    List<Tag> listTags();
}
