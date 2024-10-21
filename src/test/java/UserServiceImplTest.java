import org.example.entity.User;
import org.example.repository.TokenRepository;
import org.example.repository.UserRepository;
import org.example.service.UserServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class UserServiceImplTest {

    private UserRepository userRepositoryMock;
    private TokenRepository tokenRepositoryMock;
    private UserServiceImpl userService;

    @BeforeEach
    public void setUp() {

        userRepositoryMock = mock(UserRepository.class);
        tokenRepositoryMock = mock(TokenRepository.class);


        userService = new UserServiceImpl( tokenRepositoryMock,userRepositoryMock);
    }

    @Test
    public void testCreateUser_ShouldCreateUserAndToken() {

        User user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        user.setFirstName("Test");
        user.setLastName("User");
        user.setEmail("testuser@example.com");
        user.setPassword("password123");

        // Act
        userService.createUser(user);


        verify(userRepositoryMock).createUser(user);
        verify(tokenRepositoryMock).createToken(user);
    }

    @Test
    public void testCreateUser_ShouldOnlyCreateUserWhenIdIsNull() {
        // Arrange
        User user = new User();
        user.setId(null); // Simulate that the user doesn't yet have an ID (not saved yet)
        user.setUsername("testuser");
        user.setFirstName("Test");
        user.setLastName("User");
        user.setEmail("testuser@example.com");
        user.setPassword("password123");

        // Act
        userService.createUser(user);


        verify(userRepositoryMock).createUser(user);
        verify(tokenRepositoryMock, never()).createToken(user);
    }

    @Test
    public void testReadUser() {
        // Arrange
        User user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        user.setFirstName("Test");
        user.setLastName("User");
        user.setEmail("testuser@example.com");
        user.setPassword("password123");

        when(userRepositoryMock.readUser(1L)).thenReturn(user);

        // Act
        User result = userService.readUser(1L);

        // Assert
        assertNotNull(result);
        assertEquals("testuser", result.getUsername());
        verify(userRepositoryMock).readUser(1L);
    }

    @Test
    public void testListUsers() {
        // Arrange
        List<User> users = new ArrayList<>();
        User user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        users.add(user);
        when(userRepositoryMock.listUsers()).thenReturn(users);

        // Act
        List<User> result = userService.listUsers();

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("testuser", result.get(0).getUsername());
        verify(userRepositoryMock).listUsers();
    }

    @Test
    public void testUpdateUser() {
        // Arrange
        User user = new User();
        user.setId(1L);
        user.setUsername("updateduser");
        user.setFirstName("Updated");
        user.setLastName("User");
        user.setEmail("updateduser@example.com");
        user.setPassword("newpassword123");

        // Act
        userService.updateUser(user);

        // Assert
        verify(userRepositoryMock).updateUser(user);
    }

    @Test
    public void testDeleteUser() {
        // Arrange
        Long userId = 1L;

        // Act
        userService.deleteUser(userId);

        // Assert
        verify(userRepositoryMock).deleteUser(userId);
    }

    @Test
    public void testSearchUsers() {
        // Arrange
        List<User> users = new ArrayList<>();
        User user = new User();
        user.setId(1L);
        user.setUsername("searchuser");
        users.add(user);
        when(userRepositoryMock.search("searchuser")).thenReturn(users);

        // Act
        List<User> result = userService.search("searchuser");

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("searchuser", result.get(0).getUsername());
        verify(userRepositoryMock).search("searchuser");
    }
}
