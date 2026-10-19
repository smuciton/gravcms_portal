---
title: Contact Form
menu: Contact
form:
    name: contact-form
    fields:
        - name: name
          label: Name
          placeholder: Enter your name
          autofocus: on
          autocomplete: on
          type: text
          validate:
            required: true

        - name: email
          label: Email
          placeholder: Enter your email address
          type: text
          validate:
            rule: email
            required: true

        - name: message
          label: Message
          size: long
          placeholder: Enter your message
          type: textarea
          validate:
            required: true

    buttons:
        - type: submit
          value: Submit

    process:
        - save:
            fileprefix: contact-
            dateformat: Ymd-His-u
            extension: txt
        - message: Thank you for your feedback!
        - display: thankyou
---

Use this form to test Cloudflare features on POST requests (WAF rules, Rate Limiting, Turnstile, Bot Management).
