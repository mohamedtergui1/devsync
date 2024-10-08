package org.example.service;

import org.example.entity.Tag;
import org.example.repository.TagRepository;
import org.example.repository.TagRepositoryImpl;

import java.util.List;

public class TagServiceImpl implements TagService {
    TagRepository tagRepository = new TagRepositoryImpl();
    @Override
    public void createTag(Tag tag) {
        tagRepository.createTag(tag);
    }

    @Override
    public Tag readTag(long id) {
        return tagRepository.readTag(id);
    }

    @Override
    public List<Tag> listTags() {
        return tagRepository.listTags();
    }

    @Override
    public void updateTag(Tag tag) {
        tagRepository.updateTag(tag);
    }

    @Override
    public void deleteTag(Long id) {
        tagRepository.deleteTag(id);
    }


}
