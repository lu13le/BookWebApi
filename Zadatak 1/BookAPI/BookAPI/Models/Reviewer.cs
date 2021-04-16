using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookAPI.Models
{
    public class Reviewer
    {
        //properties
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Required]
        [MaxLength(100, ErrorMessage = "Reviewer first name must be up to 100 characters in lenght")]
        public string FirstName { get; set; }
        [Required]
        [MaxLength(200, ErrorMessage = "Reviewer last name must be up to 200 characters in lenght")]
        public string LastName { get; set; }

        //representing relation between tables
        public virtual ICollection<Review> Reviews { get; set; }
    }
}
