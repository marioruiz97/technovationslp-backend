package org.desarrolladorslp.technovation.repository;

import org.desarrolladorslp.technovation.models.Batch;
import org.desarrolladorslp.technovation.models.Deliverable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface DeliverableRepository extends JpaRepository<Deliverable, UUID> {


    List<Deliverable> findByBatch(Batch batch);

    @Modifying
    @Query(value = "INSERT INTO deliverables_by_session (deliverable_id, session_id, type) " +
            "SELECT :deliverableId, s.id, :type FROM sessions s WHERE s.id = :sessionId AND batch_id = (" +
            "SELECT batch_id FROM deliverables WHERE id = :deliverableId)"
            , nativeQuery = true)
    int assignDeliverableToSession(UUID deliverableId, UUID sessionId, String type);
}