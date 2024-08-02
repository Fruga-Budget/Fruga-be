# Fruga Backend Service (Fruga-be)

[Live Deployment Link](https://fruga-be-340d88ac3f29.herokuapp.com/)

**Note:** This repository contains the backend service for the Fruga application. The backend is built using Ruby on Rails and provides a RESTful API to manage budget-related data.

## Requirements
- Ruby 3.2.2
- Rails 7.1.4
- PostgreSQL
- Node

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/Fruga-Budget/Fruga-be.git
cd Fruga-be
```
### Install Dependencies
Ruby and Rails dependencies:

```bash
bundle install
```

### Database Setup
Create and setup the database:

```bash
rails db:create
rails db:migrate
rails db:seed
```
### Environment Variables
Create a .env file in the root directory and add the following environment variables:

```ruby
API_BASE_URL="your_url_to_py_service"
```

### Start the Server
To start the Rails server, run:

```bash
rails server
```

The server will be available at http://localhost:3000.

## Usage
### API Endpoints

The API provides endpoints for managing budget-related data. Click each end point to see more details.

<details>
<summary> End Point 1 - Getting a User's Advices </summary>

**Request**

```http
GET /api/v1/users/:user_id/advices
```

**Response**

```json
{
  "data": [
    {
      "id": "1",
      "type": "advice",
      "attributes": {
        "total_income": 5000,
        "needs_total": 2500,
        "wants_total": 1700,
        "savings_total": 1000,
        "expenses": {
          "needs": [
            {
              "name": "Rent",
              "amount": 1500,
              "description": "On a lease, this can't be changed!",
              "isNegotiable": false
            },
            {
              "name": "Utilities",
              "amount": 500,
              "description": "",
              "isNegotiable": true
            },
            {
              "name": "Misc.",
              "amount": 500,
              "description": "Food Budget, Gas",
              "isNegotiable": false
            }
          ],
          "wants": [
            {
              "name": "Dining Out",
              "amount": 500,
              "description": "Yummy!"
            },
            {
              "name": "Entertainment",
              "amount": 500,
              "description": "Going to the movies is important to me"
            },
            {
              "name": "Starbucks Coffee",
              "amount": 200,
              "description": "I don't know how to make coffee"
            },
            {
              "name": "Shoes",
              "amount": 500,
              "description": "Every time I drive by DSW I buy shoes"
            }
          ],
          "savings": [
            {
              "name": "401k",
              "amount": 200,
              "description": "Deposited from paycheck at work."
            },
            {
              "name": "Savings Account",
              "amount": 800,
              "description": "0.5% apr"
            }
          ]
        },
        "advice": [
          "Based on the user's current budget breakdown, they are not following the 50/30/20 rule",
          "Here are some specific recommendations on how they can adjust their budget:\n\n1",
          "**Rent** (Fixed - Not Negotiable): 30% of income is already allocated.\n2",
          "**Utilities** (Variable - Negotiable): Consider reducing usage to lower costs.\n3",
          "**Miscellaneous** (Fixed - Not Negotiable): 10% of income is already allocated.\n4",
          "**Wants Total**: Currently 30% of income, exceeding the recommended 30%.\n\nTo meet the 50/30/20 rule, the user can consider the following changes:\n- **Dining Out**: Reduce to $250.\n- **Entertainment**: Reduce to $250.\n- **Starbucks Coffee**: Reduce to $100.\n- **Shoes**: Reduce to $250.\n\nRevised Budget Breakdown:\n- Needs: $2500 (Rent: $1500, Utilities: $250, Misc.: $750)\n- Wants: $1250 (Dining Out: $250, Entertainment: $250, Starbucks Coffee: $100, Shoes: $250)\n- Savings: $1250 (401k: $200, Savings"
        ]
      }
    },
    {
      "id": "2",
      "type": "advice",
      "attributes": {
        "total_income": 7000,
        "needs_total": 4000,
        "wants_total": 1700,
        "savings_total": 1000,
        "expenses": {
          "needs": [
            {
              "name": "Rent",
              "amount": 3000,
              "description": "On a lease, this can't be changed!",
              "isNegotiable": false
            },
            {
              "name": "Utilities",
              "amount": 500,
              "description": "",
              "isNegotiable": true
            },
            {
              "name": "Misc.",
              "amount": 500,
              "description": "Food Budget, Gas",
              "isNegotiable": false
            }
          ],
          "wants": [
            {
              "name": "Dining Out",
              "amount": 500,
              "description": "Yummy!"
            },
            {
              "name": "Entertainment",
              "amount": 500,
              "description": "Going to the movies is important to me"
            },
            {
              "name": "Starbucks Coffee",
              "amount": 200,
              "description": "I don't know how to make coffee"
            },
            {
              "name": "Shoes",
              "amount": 500,
              "description": "Every time I drive by DSW I buy shoes"
            }
          ],
          "savings": [
            {
              "name": "401k",
              "amount": 200,
              "description": "Deposited from paycheck at work."
            },
            {
              "name": "Savings Account",
              "amount": 800,
              "description": "0.5% apr"
            }
          ]
        },
        "advice": [
          "User's current budget breakdown:\n- Needs: $4000 (Rent $3000, Utilities $500, Misc",
          "$500)\n- Wants: $1700 (Dining Out $500, Entertainment $500, Starbucks Coffee $200, Shoes $500)\n- Savings: $1000 (401k $200, Savings Account $800)\n\nTotal expenses: $6700\nTotal savings: $1000\n\nUser's current budget does not match the 50/30/20 rule",
          "To adjust, consider:\n1",
          "Reduce spending on wants such as Dining Out, Entertainment, Starbucks Coffee, and Shoes.\n2",
          "Increase savings contribution if possible.\n3",
          "Negotiate Utilities and explore ways to decrease Misc",
          "expenses.\n\nRevised budget breakdown to meet 50/30/20 rule:\n- Needs: $3500 (Rent $3000, Utilities $300, Misc",
          "$200)\n- Wants: $2100 (Dining Out $300, Entertainment $300, Starbucks Coffee $100, Shoes $1400)\n- Savings: $1400\n\nTotal expenses: $7000\nTotal savings: $1400\n\nThis adjusted budget aligns more closely with the 50/30/20 rule by allocating 50%"
        ]
      }
    }
  ]
}
```
</details>

<details>
  <summary> End Point 2 - Create an Advice </summary>

**Request**

```http
POST /api/v1/users/:user_id/advices
```

**Body**

```json
{
  "total_income": 5000,
  "needs": [
    {"name": "Rent", "cost": 1500, "description": "On a lease, this can't be changed!", "isNegotiable": false},
    {"name": "Utilities", "cost": 500, "description": "", "isNegotiable": true},
    {"name": "Misc.", "cost": 500, "description": "Food Budget, Gas", "isNegotiable": false}
  ],
  "wants": [
    {"name": "Dining Out", "cost": 500, "description": "Yummy!"},
    {"name": "Entertainment", "cost": 500, "description": "Going to the movies is important to me"},
    {"name": "Starbucks Coffee", "cost": 200, "description": "I don't know how to make coffee"},
    {"name": "Shoes", "cost": 500, "description": "Every time I drive by DSW I buy shoes"}
  ],
  "savings": [
    {"name": "401k", "cost": 200, "description": "Deposited from paycheck at work."},
    {"name": "Savings Account", "cost": 800, "description": "0.5% apr"}
  ]
}
```

**Response**

```json
{
  "data": {
    "id": "3",
    "type": "advice",
    "attributes": {
      "total_income": 7000,
      "needs_total": 4000,
      "wants_total": 1700,
      "savings_total": 1000,
      "expenses": {
        "needs": [
          {
            "name": "Rent",
            "amount": 3000,
            "description": "On a lease, this can't be changed!",
            "isNegotiable": false
          },
          {
            "name": "Utilities",
            "amount": 500,
            "description": "",
            "isNegotiable": true
          },
          {
            "name": "Misc.",
            "amount": 500,
            "description": "Food Budget, Gas",
            "isNegotiable": false
          }
        ],
        "wants": [
          {
            "name": "Dining Out",
            "amount": 500,
            "description": "Yummy!"
          },
          {
            "name": "Entertainment",
            "amount": 500,
            "description": "Going to the movies is important to me"
          },
          {
            "name": "Starbucks Coffee",
            "amount": 200,
            "description": "I don't know how to make coffee"
          },
          {
            "name": "Shoes",
            "amount": 500,
            "description": "Every time I drive by DSW I buy shoes"
          }
        ],
        "savings": [
          {
            "name": "401k",
            "amount": 200,
            "description": "Deposited from paycheck at work."
          },
          {
            "name": "Savings Account",
            "amount": 800,
            "description": "0.5% apr"
          }
        ]
      },
      "advice": [
        "The user's budget does not match the 50/30/20 rule",
        "To adjust, they can consider reducing expenses on Dining Out, Entertainment, Starbucks Coffee, and Shoes since these are wants and negotiable",
        "They can increase savings for better financial planning",
        "Here's a revised budget breakdown: Needs: Rent $3000, Utilities $500, Misc",
        "$500; Wants: Dining Out $300, Entertainment $300, Starbucks Coffee $100, Shoes $300; Savings: 401k $200, Savings Account $1000."
      ]
    }
  }
}
```
</details>

<details>
<summary> End Point 3 - Create a User </summary>

**Note:** there is a 10 character password requirement

**Request**

```http
POST /api/v1/users
```

**Body**

```json
{
  "user_name": "Bolt",
  "password": "treats4lyf",
  "password_confirmation": "treats4lyf"
}
```

**Response**

```json
{
  "data": {
    "id": "4",
    "type": "user",
    "attributes": {
      "user_name": "Bolt"
    }
  }
}
```
</details>

<details>
<summary> End Point 4 - Login a User </summary>

**Request**

```http
POST /api/v1/sessions
```

**Body**

```json
{
  "user_name": "Odell",
  "password": "treats4lyf"
}
```

**Response**

```json
{
  "data": {
    "id": "4",
    "type": "user",
    "attributes": {
      "user_name": "Bolt"
    }
  }
}
```
</details>

### Tests

* 34 Total Tests (343 / 346 LOC (99.13%) covered)
* 11 Request Tests (252 / 255 LOC (99.82%) covered)
* 23 Model Tests (96 / 96 LOC (100.00%) covered)

To run the test suite, use:
```bash
bundle exec rspec spec
```

### Contributions and contributing

* Steddman Bell | [GitHub](https://github.com/Steddy1Love), [LinkedIn](https://www.linkedin.com/in/steddman-bell/)
* Nico Shanstrom | [GitHub](https://github.com/NicoShanstrom), [LinkedIn](https://www.linkedin.com/in/nicoshanstrom/)
* Grant Davis | [GitHub](https://github.com/grantdavis303), [LinkedIn](https://www.linkedin.com/in/grantdavis303/)

*Please submit a PR using the PR template mentioned in the readme in .github repo.*
