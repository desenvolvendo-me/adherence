// app/javascript/controllers/product_machines_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["container", "template", "machineSelect", "row"]
    static values = {
        machineIndex: Number
    }

    connect() {
        this.updateMachineOptions()
    }

    addMachine(event) {
        event.preventDefault()

        const content = this.templateTarget.innerHTML
            .replace(/NEW_RECORD/g, this.machineIndexValue)

        this.containerTarget.insertAdjacentHTML("beforeend", content)
        this.machineIndexValue++
        this.updateMachineOptions()
    }

    removeMachine(event) {
        event.preventDefault()
        const row = event.target.closest(".machine-row")

        // Se tem ID, marca para destruição
        const destroyInput = row.querySelector('input[name*="_destroy"]')
        if (destroyInput) {
            destroyInput.value = "1"
            row.classList.add("hidden")
        } else {
            // Se não tem ID (é um novo registro), remove do DOM
            row.remove()
        }

        this.updateMachineOptions()
    }

    machineSelected(event) {
        this.updateMachineOptions()
    }

    updateMachineOptions() {
        const selectedMachines = this.getSelectedMachines()

        this.machineSelectTargets.forEach(select => {
            const row = select.closest(".machine-row")
            // Ignora selects em rows marcadas para destruição
            if (row.classList.contains("hidden")) return

            Array.from(select.options).forEach(option => {
                if (option.value && option.value !== select.value) {
                    option.disabled = selectedMachines.includes(option.value)
                }
            })
        })
    }

    getSelectedMachines() {
        return this.machineSelectTargets
            .map(select => {
                const row = select.closest(".machine-row")
                // Só considera valores de rows não marcadas para destruição
                if (!row.classList.contains("hidden")) {
                    return select.value
                }
                return ""
            })
            .filter(value => value !== "")
    }
}