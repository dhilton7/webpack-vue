<template>
	<v-layout row wrap pa-4>
    <v-flex xs12>
      <h3 style="display: inline">Analyze Property Now</h3>
       <v-btn primary large @click="runAnalysis">Analyze</v-btn>
    </v-flex>
    <v-flex xs12 md8>
      <v-layout row wrap>
        <v-flex xs12 md6>
          <v-card>
            <v-card-title>Property Information</v-card-title>
            <v-card-text>
              <v-text-field type="number" label="Purchase Price" v-model="purchasePrice" />
              <v-text-field type="number" label="Down Payment" v-model="downPayment" />
              <v-text-field type="number" label="Loan Amount" v-model="loanAmount" />
              <v-text-field type="number" label="Closing Costs" v-model="closingCosts" />
              <v-text-field type="decimal" label="Interest Rate" v-model="interestRate" />
               <v-text-field type="number" label="Ammortization (Years)" v-model="ammortization" />
              <v-text-field type="number" label="Listing Price" v-model="listingPrice" />
              <v-text-field type="number" label="ARV" v-model="arv" />
              <v-text-field type="number" label="Estimated Repairs" v-model="estimatedRepairs" />
            </v-card-text>
          </v-card>
        </v-flex>
        <v-flex xs12 md6>
          <v-card>
            <v-card-title>Income & Expenses</v-card-title>
            <v-card-text>
              <v-text-field type="number" label="Rent" v-model="rent" />
              <v-text-field type="number" label="Property Tax" v-model="propertyTax" />
              <v-text-field type="number" label="Insurance" v-model="insurance" />
              <v-text-field type="number" label="PMI" v-model="pmi" />
              <v-text-field type="number" label="Other Expenses" v-model="otherExpenses" />
              <v-text-field type="number" label="Vacancy (%)" v-model="vacancy" />
              <v-text-field type="number" label="Repairs & Maintenance (%)" v-model="repairs" />
              <v-text-field type="number" label="Capital Expenditures (%)" v-model="capex" />
              <v-text-field type="number" label="Property Management (%)" v-model="propertyManagement" />
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-flex>
    <v-flex xs12 md4 v-if="displayResults">
      <v-card>
        <v-card-title>Results</v-card-title>
        <v-card-text>
          <p>Monthly Payment: ${{ monthlyPayment }}</p>
          <p>Total Monthly Payment: ${{ totalMonthlyPayment }}</p>
          <p>Vacancy Expense: ${{ vacancyExpense }}</p>
          <p>Repairs & Maintenance: ${{ repairsExpense }}</p>
          <p>CapEx: ${{ capExCost }}</p>
          <p>Property Management Expense: ${{ pmExpense }}</p>
          <p>Operating Expenses: ${{  }}</p>
        </v-card-text>
      </v-card>
    </v-flex>
	</v-layout>
</template>

<script>
	export default {
    data() {
      return {
        purchasePrice: null,
        downPayment: null,
        loanAmount: null,
        closingCosts: null,
        interestRate: null,
        ammortization: null,
        listingPrice: null,
        arv: null,
        estimatedRepairs: null,
        rent: null,
        propertyTax: null,
        insurance: null,
        pmi: null,
        otherExpenses: null,
        vacancy: null,
        repairs: null,
        capex: null,
        propertyManagement: null,
      }
    },
    computed: {
      displayResults() {
        // return this.purchasePrice != null && this.estimatedRepairs != null && this.propertyTax != null && this.rent != null
        return true
      },
      monthlyPayment() {
        const c = this.monthlyInterest(),
         n = this.ammortization * 12
        const exponential = Math.pow((1 + c), n)
        // const val = 
        return (this.loanAmount * ((c * exponential) / (exponential - 1))).toFixed(2) || null
      },
      vacancyExpense() {
        return (this.rent * (this.vacancy / 100.00)).toFixed(2)
      },
      repairsExpense() {
        return (this.rent * (this.repairs / 100.00)).toFixed(2)
      },
      capExCost() {
        return (this.rent * (this.capex) / 100.00).toFixed(2)
      },
      pmExpense() {
        return (this.rent * (this.propertyManagement) / 100.00).toFixed(2)
      },
      totalMonthlyPayment() {
        // this is doing string concat... need to fix
        // return this.monthlyPayment + this.insurance + this.propertyTax
        return ''
      }
    },
    methods: {
      runAnalysis() {
      },
      monthlyInterest() {
        return this.interestRate / (100.00 * 12)
      }
    }
  }
</script>
