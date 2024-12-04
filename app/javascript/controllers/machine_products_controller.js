// app/javascript/controllers/machine_products_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["productSelect"]

    async updateProducts(event) {
        if (!this.hasProductSelectTarget) {
            console.warn("Product select target not found")
            return
        }

        const machineId = event.target.value
        if (!machineId) {
            this.clearProducts()
            return
        }

        try {
            const response = await fetch(`/machines/${machineId}/products`)
            if (!response.ok) throw new Error('Network response was not ok')

            const products = await response.json()
            this.updateProductOptions(products)
        } catch (error) {
            console.error("Error fetching products:", error)
            this.clearProducts()
        }
    }

    updateProductOptions(products) {
        this.productSelectTarget.innerHTML = '<option value="">Selecione o produto</option>'

        products.forEach(product => {
            const option = document.createElement("option")
            option.value = product.id
            option.textContent = product.name
            this.productSelectTarget.appendChild(option)
        })
    }

    clearProducts() {
        if (this.hasProductSelectTarget) {
            this.productSelectTarget.innerHTML = '<option value="">Selecione o produto</option>'
        }
    }
}