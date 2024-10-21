package org.example.repository;

import org.example.entity.Token;
import org.example.entity.User;
import org.example.repository.base.Repository;

public class TokenRepositoryImpl extends Repository implements TokenRepository {
   public void createToken(User user)  {
        executeInTransaction((em) -> {

            // Create and persist the Token entity associated with the User
            Token token = new Token();
            token.setUser(user);
            token.setDeletionTokenCount(1);
            token.setUpdateTokenCount(2);
            em.persist(token);
        });
    }
}
