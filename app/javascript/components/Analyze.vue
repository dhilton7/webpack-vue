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
              <v-layout>
                <v-flex row xs5>
                  <v-text-field type="number" label="Purchase Price" v-model="purchasePrice" />
                </v-flex>
                <v-flex row xs4 offset-xs1>
                  <v-text-field type="number" label="Down Payment" v-model="downPayment" />
                </v-flex>
                <v-flex row xs2>
                  <v-text-field type="number" label="%" v-model="percentDown" />
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="Loan Amount" v-model="loanAmount" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                  <v-text-field type="number" label="Closing Costs" v-model="closingCosts" />
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="Interest Rate" v-model="interestRate" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                  <v-text-field type="number" label="Amortized Years" v-model="amortization" />
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="Listing Price" v-model="listingPrice" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                  <v-text-field type="number" label="ARV" v-model="arv" />
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="Estimated Repairs" v-model="estimatedRepairs" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                </v-flex>
              </v-layout>
            </v-card-text>
          </v-card>
        </v-flex>
        <v-flex xs12 md6>
          <v-card>
            <v-card-title>Income & Expenses</v-card-title>
            <v-card-text>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="Rent" v-model="rent" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="Property Tax" v-model="propertyTax" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                  <v-text-field type="number" label="Insurance" v-model="insurance" />
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="PMI" v-model="pmi" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                  <v-text-field type="number" label="Other Expenses" v-model="otherExpenses" />
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="Vacancy (%)" v-model="vacancy" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                  <v-text-field type="number" label="Repairs (%)" v-model="repairs" />
                </v-flex>
              </v-layout>
              <v-layout row wrap>
                <v-flex xs5>
                  <v-text-field type="number" label="CapEx (%)" v-model="capex" />
                </v-flex>
                <v-flex xs5 offset-xs2>
                  <v-text-field type="number" label="Management (%)" v-model="propertyManagement" />
                </v-flex>
              </v-layout>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-flex>
    <v-flex xs12 md4 v-if="displayResults">
      <v-card>
        <v-card-title>Results</v-card-title>
        <v-card-text>
          <p v-for="result in resultSet">
            <strong>{{ result.name }}:</strong> ${{ resultsFor(result.name) }}
          </p>
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
        percentDown: null,
        loanAmount: null,
        closingCosts: null,
        interestRate: null,
        amortization: null,
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
        resultSet: [
          { id: 1, name: 'Monthly P&I' },
          { id: 2, name: 'Total Monthly Payment' },
          { id: 3, name: 'Vacancy Expense' },
          { id: 4, name: 'Repairs & Maintenance' },
          { id: 5, name: 'CapEx' },
          { id: 6, name: 'Management Expense' },
          { id: 7, name: 'Operating Expense' },
          { id: 8, name: 'Total Income'},
          { id: 9, name: 'Net Operating Income' },
          { id: 10, name: 'Cash on Cash' },
          { id: 11, name: 'ROI' },
          { id: 12, name: 'Cap Rate' }
        ]
      }
    },
    computed: {
      displayResults() {
        // return this.purchasePrice != null && this.estimatedRepairs != null && this.propertyTax != null && this.rent != null
        return true
      },
      monthlyPayment() {
        const c = this.monthlyInterest(),
         n = this.amortization * 12
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
        return parseFloat(this.monthlyPayment) + parseFloat(this.insurance) + parseFloat(this.propertyTax)
      },
      // downPaymentValue() {
      //   if (this.downPayment != null ) { return this.downPayment }
      //   return (this.percentDown != null && this.purchasePrice != null) ? (this.percentDown * this.purchasePrice / 100.00) : null
      // }
    },
    watch: {
      percentDown(value) {
        // todo: I don't think we want instant feedback... check to see if value > 0, not null, etc
        this.downPayment = this.purchasePrice * (value / 100.00)
        this.setLoanAmount()
      },
      downPayment(value) {
        this.percentDown = value * 100.00 / this.purchasePrice
        this.setLoanAmount()
      }
    },
    methods: {
      runAnalysis() {
      },
      monthlyInterest() {
        return this.interestRate / (100.00 * 12)
      },
      updateDownPaymentFields() {

      },
      setLoanAmount() {
        this.loanAmount = this.purchasePrice - this.downPayment
      },
      resultsFor(name) {
        switch(name) {
          case this.resultSet[0].name:
            return this.monthlyPayment
          case this.resultSet[1].name:
            return this.totalMonthlyPayment
          case this.resultSet[2].name:
            return this.vacancyExpense
          case this.resultSet[3].name:
            return this.repairsExpense
          case this.resultSet[4].name:
            return this.capExCost
          case this.resultSet[5].name:
            return this.pmExpense
          case this.resultSet[6].name:
          case this.resultSet[7].name:
          case this.resultSet[8].name:
          case this.resultSet[9].name:
          case this.resultSet[10].name:
          case this.resultSet[11].name:
          case this.resultSet[12].name:
          default:
            return ''
        }
      }
    }
  }
</script>
