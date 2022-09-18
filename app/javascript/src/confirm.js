// Custom TailwindCSS modals for confirm dialogs
function insertConfirmModal(message, element) {
  let content = `
    <div id="confirm-modal" class="z-50 animated fadeIn fixed top-0 left-0 w-full h-full table" style="background-color: rgba(0, 0, 0, 0.8);">
      <div class="table-cell align-middle">
        <div class="bg-white mx-auto rounded shadow p-8 max-w-sm">
          <h4>${message}</h4>
          <div class="flex justify-end items-center flex-wrap mt-6">
            <button data-behavior="cancel" class="btn btn-light-gray mr-2">Cancel</button>
            <button data-behavior="commit" class="btn btn-danger focus:outline-none">Confirm</button>
          </div>
        </div>
      </div>
    </div>
  `

  document.body.insertAdjacentHTML('beforeend', content)
  document.activeElement.blur()
  return document.getElementById("confirm-modal")
}

Turbo.setConfirmMethod((message, element) => {
  let dialog = insertConfirmModal(message, element)

  return new Promise((resolve, reject) => {
    dialog.querySelector("[data-behavior='cancel']").addEventListener("click", (event) => {
      dialog.remove()
      resolve(false)
    }, { once: true })
    dialog.querySelector("[data-behavior='commit']").addEventListener("click", (event) => {
      dialog.remove()
      resolve(true)
    }, { once: true })
  })
})
