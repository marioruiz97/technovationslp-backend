package org.desarrolladorslp.technovation.services;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.desarrolladorslp.technovation.dto.MessageBodyDTO;
import org.desarrolladorslp.technovation.dto.MessageHeaderDTO;

public interface MessageService {

    Map<String, List<MessageHeaderDTO>> getMessagesByUser(UUID userReceiverId);

    MessageBodyDTO getSpecificMessageByUser(UUID messageId, UUID userReceiverId);

    void markMessageAsRead(UUID messageId);

    void markMessageAsUnread(UUID messageId);

    void markMessageAsHighPriority(UUID messageId);

    void markMessageAsLowPriority(UUID messageId);
}
