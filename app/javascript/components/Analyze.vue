<template>
	<v-layout row wrap pa-4>
    <v-flex xs12 pb-4>
      <h3 class="display-2" style="display: inline">Analyze Property Now</h3>
    </v-flex>
    <v-flex xs12 md8>
      <v-layout row wrap>
        <v-flex xs12 md6>
          <v-card>
            <v-card-title class="title">Property Information</v-card-title>
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
            <v-card-title class="title">Income & Expenses</v-card-title>
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
        <v-card-title class="title">Results</v-card-title>
        <v-card-text>
          <p v-for="(result, index) in resultSet" :key="index">
            <strong>{{ result }}:</strong> <span class="right">{{ resultsFor(result) }}</span>
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
          'Monthly P&I',
          'Total Monthly Payment',
          'Vacancy Expense',
          'Repairs & Maintenance',
          'CapEx',
          'Management Expense',
          'Operating Expense',
          'Total Income',
          'Net Operating Income',
          'Cash Flow',
          'Cash on Cash ROI',
          'Cap Rate'
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
      operatingExpense() {
        return (Number(this.pmExpense) + Number(this.vacancyExpense) + Number(this.capExCost) + Number(this.pmExpense)).toFixed(2)
      },
      totalMonthlyPayment() {
        return (Number(this.monthlyPayment) + Number(this.insurance) + Number(this.propertyTax)).toFixed(2)
      },
      totalExpense() {
        return Number(this.totalMonthlyPayment) + Number(this.operatingExpense)
      },
      operatingIncome() {
        return this.rent
      },
      totalIncome() {
        return this.rent // + this.otherIncome
      },
      netOperatingIncome() {
        return Number(this.operatingIncome) - Number(this.operatingExpense)
      },
      cashFlow() {
        return (Number(this.operatingIncome) - Number(this.totalExpense)).toFixed(2)
      },
      // TODO: need to include closing costs here.
      roi() {
        return (Number(this.cashFlow) * 12 * 100.00 / this.downPayment).toFixed(2)
      },
      capRate() {
        return (this.netOperatingIncome * 12 * 100.000 / this.purchasePrice).toFixed(3)
      }
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
      monthlyInterest() {
        return this.interestRate / (100.00 * 12)
      },
      setLoanAmount() {
        this.loanAmount = this.purchasePrice - this.downPayment
      },
      resultsFor(name) {
        switch(name) {
          case this.resultSet[0]:
            return `$${this.monthlyPayment}`
          case this.resultSet[1]:
            return `$${this.totalMonthlyPayment}`
          case this.resultSet[2]:
            return `$${this.vacancyExpense}`
          case this.resultSet[3]:
            return `$${this.repairsExpense}`
          case this.resultSet[4]:
            return `$${this.capExCost}`
          case this.resultSet[5]:
            return `$${this.pmExpense}`
          case this.resultSet[6]:
            return `$${this.operatingExpense}`
          case this.resultSet[7]:
            return `$${this.totalIncome}`
          case this.resultSet[8]:
            return `$${this.netOperatingIncome}`
          case this.resultSet[9]:
            return `$${this.cashFlow}`
          case this.resultSet[10]:
            return `${this.roi}%`
          case this.resultSet[11]:
            return `${this.capRate}%`
          default:
            return ''
        }
      },
    }
  }
</script>
