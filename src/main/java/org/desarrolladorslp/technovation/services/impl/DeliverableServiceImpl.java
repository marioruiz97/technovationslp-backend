package org.desarrolladorslp.technovation.services.impl;

import org.desarrolladorslp.technovation.dto.DeliverableDTO;
import org.desarrolladorslp.technovation.models.Batch;
import org.desarrolladorslp.technovation.models.Deliverable;
import org.desarrolladorslp.technovation.repository.DeliverableRepository;
import org.desarrolladorslp.technovation.services.DeliverableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Service
public class DeliverableServiceImpl implements DeliverableService {

    private DeliverableRepository deliverableRepository;

    @Override
    @Transactional
    public DeliverableDTO save(DeliverableDTO deliverableDTO) {
        Deliverable deliverable = convertToEntity(deliverableDTO);
        deliverable.setId(UUID.randomUUID());
        return convertToDTO(deliverableRepository.save(deliverable));
    }

    @Autowired
    public void setDeliverableRepository(DeliverableRepository deliverableRepository) {
        this.deliverableRepository = deliverableRepository;
    }

    private Deliverable convertToEntity(DeliverableDTO deliverableDTO) {
        return Deliverable.builder()
                .id(deliverableDTO.getId())
                .dueDate(ZonedDateTime.parse(deliverableDTO.getDueDate(), DateTimeFormatter.ISO_DATE_TIME))
                .title(deliverableDTO.getTitle())
                .description(deliverableDTO.getDescription())
                .batch(Batch.builder().id(deliverableDTO.getBatchId()).build())
                .build();
    }

    private DeliverableDTO convertToDTO(Deliverable deliverable) {
        return DeliverableDTO.builder()
                .id(deliverable.getId())
                .dueDate(deliverable.getDueDate().format(DateTimeFormatter.ISO_DATE_TIME))
                .title(deliverable.getTitle())
                .description(deliverable.getDescription())
                .batchId(deliverable.getBatch().getId())
                .build();
    }


}
