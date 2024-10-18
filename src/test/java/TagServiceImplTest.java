import org.example.entity.Tag;
import org.example.repository.TagRepository;
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
    private TagRepository tagRepository;  // Mock the interface, not the implementation

    @InjectMocks
    private TagServiceImpl tagService;

    private Tag tag;

    @BeforeEach
    public void setUp() {
        tag = new Tag("adz");  // Set up a Tag object with name "adz"
    }

    @Test
    public void testCreateTag() {
        // Act
        tagService.createTag(tag);

        // Assert
        verify(tagRepository, times(1)).createTag(tag);  // Verify repository's createTag was called once
    }

    @Test
    public void testReadTag() {
        // Arrange
        when(tagRepository.readTag(1L)).thenReturn(tag);  // Mock the repository to return the tag for the given ID

        // Act
        Tag result = tagService.readTag(1L);

        // Assert
        assertNotNull(result); // Assert that the result is not null
        assertEquals("adz", result.getName()); // Assert that the tag's name is "adz"
        verify(tagRepository, times(1)).readTag(1L); // Verify repository's readTag was called once
    }

    @Test
    public void testListTags() {
        // Arrange
        List<Tag> tags = Arrays.asList(tag, new Tag("example"));  // Create a list of tags
        when(tagRepository.listTags()).thenReturn(tags);  // Mock the repository to return the list of tags

        // Act
        List<Tag> result = tagService.listTags();

        // Assert
        assertNotNull(result);
        assertEquals(2, result.size()); // Assert that the list contains two tags
        assertTrue(result.contains(tag)); // Assert that the list contains the tag
        verify(tagRepository, times(1)).listTags();  // Verify repository's listTags was called once
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
