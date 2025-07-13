function showCustomConfirm(message, onConfirm, onCancel) {
  const modal = document.getElementById("confirmModal");
  const msg = document.getElementById("confirmMessage");
  const confirmBtn = document.getElementById("modalConfirmBtn");
  const cancelBtn = document.getElementById("modalCancelBtn");

  msg.textContent = message;

  modal.style.display = "flex";

  function cleanup() {
    modal.style.display = "none";
    confirmBtn.removeEventListener("click", handleConfirm);
    cancelBtn.removeEventListener("click", handleCancel);
  }

  function handleConfirm() {
    cleanup();
    onConfirm();
  }

  function handleCancel() {
    cleanup();
    if (onCancel) onCancel();
  }

  confirmBtn.addEventListener("click", handleConfirm);
  cancelBtn.addEventListener("click", handleCancel);
}
