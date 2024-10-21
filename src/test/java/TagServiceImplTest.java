import org.example.entity.Tag;
import org.example.repository.TagRepository;
import org.example.service.TagService;
import org.example.service.TagServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class TagServiceImplTest {

    @Mock
    private TagRepository tagRepository;

    @InjectMocks
    private TagServiceImpl tagService;

    private Tag tag;

    @BeforeEach
    public void setUp() {
        tag = new Tag("adz");
    }

    @Test
    public void testCreateTag() {
        // Act
        tagService.createTag(tag);

        // Assert
        verify(tagRepository, times(1)).createTag(tag);
    }

    @Test
    public void testReadTag() {
        // Arrange
        when(tagRepository.readTag(1L)).thenReturn(tag);

        // Act
        Tag result = tagService.readTag(1L);

        // Assert
        assertNotNull(result);
        assertEquals("adz", result.getName());
        verify(tagRepository, times(1)).readTag(1L);
    }

    @Test
    public void testListTags() {
        // Arrange
        List<Tag> tags = Arrays.asList(tag, new Tag("example"));
        when(tagRepository.listTags()).thenReturn(tags);

        // Act
        List<Tag> result = tagService.listTags();

        // Assert
        assertNotNull(result);
        assertEquals(2, result.size());
        assertTrue(result.contains(tag));
        verify(tagRepository, times(1)).listTags();
    }

    @Test
    public void testUpdateTag() {
        // Arrange
        tag.setName("adz-updated");

        // Act
        tagService.updateTag(tag);

        // Assert
        verify(tagRepository, times(1)).updateTag(tag);
    }

    @Test
    public void testDeleteTag() {
        // Act
        tagService.deleteTag(1L);


        verify(tagRepository, times(1)).deleteTag(1L);
    }
}
