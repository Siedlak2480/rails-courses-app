document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('new_participant_form')
  if (!form) return

  const csrfToken = () => {
    const el = document.querySelector('meta[name="csrf-token"]')
    return el ? el.content : ''
  }

  form.addEventListener('submit', async (ev) => {
    ev.preventDefault()
    const action = form.action
    const method = (form.method || 'POST').toUpperCase()
    const formData = new FormData(form)
    const errorsContainer = document.getElementById('participants-errors')

    errorsContainer.innerHTML = ''

    try {
      const res = await fetch(action, {
        method: method,
        headers: {
          'Accept': 'application/json',
          'X-CSRF-Token': csrfToken()
        },
        body: formData,
        credentials: 'same-origin'
      })

      const data = await res.json().catch(() => ({}))

      if (res.ok) {
        const list = document.getElementById('participants-list')
        if (list) {
          const li = document.createElement('li')
          li.id = `participant-${data.id}`
          li.innerHTML = `<strong>${data.name}</strong> — ${data.email} <a href="/participants/${data.id}/edit">Edit</a> | <a data-method="delete" href="/participants/${data.id}">Delete</a>`
          list.appendChild(li)
        }
        form.reset()
      } else {
        // display errors (array or object)
        let html = ''
        if (data.errors) {
          if (Array.isArray(data.errors)) {
            html = data.errors.map(e => `<div>${e}</div>`).join('')
          } else if (typeof data.errors === 'object') {
            html = Object.entries(data.errors).map(([k, v]) => `<div>${k}: ${v}</div>`).join('')
          } else {
            html = `<div>${JSON.stringify(data)}</div>`
          }
        } else {
          html = `<div>Unexpected error</div>`
        }
        errorsContainer.innerHTML = html
      }
    } catch (e) {
      console.error('Fetch error:', e)
      errorsContainer.innerHTML = `<div>Network error</div>`
    }
  })
})