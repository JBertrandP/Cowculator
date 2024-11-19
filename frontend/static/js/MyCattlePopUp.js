// Generic function to manage modals
function setupModal(triggerIds, modalId) {
    const modal = document.getElementById(modalId);
    const modalOverlay = document.getElementById('modalOverlay');
    const closeModal = modal.querySelector('.closeModal');

    // Show the modal
    triggerIds.forEach((triggerId) => {
        const trigger = document.getElementById(triggerId);
        trigger.addEventListener('click', (e) => {
            e.preventDefault(); // Prevent default link behavior
            modal.style.display = 'block';
            modalOverlay.style.display = 'block';
        });
    });

    // Close the modal
    function hideModal() {
        modal.style.display = 'none';
        modalOverlay.style.display = 'none';
    }

    closeModal.addEventListener('click', hideModal);
    modalOverlay.addEventListener('click', hideModal);
}

// Set up all modals
setupModal(['openModal1'], 'myModal1');
setupModal(['openModal2'], 'myModal2');
setupModal(['openModal3'], 'myModal3');